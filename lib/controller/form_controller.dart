// controllers/input_form_controller.dart
// Controller untuk mengatur logika form input data laporan
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:bersihku/ui/user/succes-screen/succes_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_indicator/loading_indicator.dart';

class InputFormController {
  // Key untuk validasi FormState di UI
  final formKey = GlobalKey<FormState>();

  // Controller untuk input teks pada masing-masing field
  final platController = TextEditingController();
  final beratKeseluruhanController = TextEditingController();
  final beratKeringController = TextEditingController();
  final beratBasahController = TextEditingController();
  final catatanController = TextEditingController();

  // Variabel untuk menyimpan pilihan lokasi drop point
  String? selectedLocation;
  String? selectedAddress;

  // Flag untuk menandai apakah proses submit sedang berjalan
  bool isLoading = false;

  // List untuk menyimpan path gambar kering dan basah
  final List<String> imagePathsKering = [];
  final List<String> imagePathsBasah = [];

  // Formatter untuk menampilkan angka dengan ribuan sesuai locale Indonesia
  final formatter = NumberFormat('#,##0', 'id_ID');

  /// Pasang listener pada controller berat untuk update total otomatis
  void initListener(VoidCallback onChanged) {
    beratKeringController.addListener(() => _updateTotal(onChanged));
    beratBasahController.addListener(() => _updateTotal(onChanged));
  }

  /// Hitung total berat (kering + basah) dan update ke controller total
  void _updateTotal(VoidCallback onChanged) {
    final kering = double.tryParse(beratKeringController.text) ?? 0;
    final basah = double.tryParse(beratBasahController.text) ?? 0;
    final total = kering + basah;

    // Set teks dengan format ribuan, lalu panggil callback untuk refresh UI
    beratKeseluruhanController.text = formatter
        .format(total)
        .replaceAll(',00', '');
    onChanged(); // Beri tahu UI agar rebuild jika perlu
  }

  /// Tambah list path gambar kering dari widget UploadImagePlaceholder
  void addImagesKering(List<Map<String, String>> images) {
    imagePathsKering.addAll(images.map((e) => e['path']!));
  }

  /// Tambah list path gambar basah dari widget UploadImagePlaceholder
  void addImagesBasah(List<Map<String, String>> images) {
    imagePathsBasah.addAll(images.map((e) => e['path']!));
  }

  /// Proses submit form: validasi, upload gambar, simpan data ke Firestore
  Future<void> submitForm(BuildContext context) async {
    if (isLoading) return; // Cegah double tap

    // 1) Validasi semua field di Form
    if (!formKey.currentState!.validate()) {
      _showMessage(context, 'Tolong lengkapi semua bidang');
      return;
    }

    // 2) Pastikan lokasi & alamat terpilih
    if (selectedLocation == null || selectedAddress == null) {
      _showMessage(context, 'Pilih lokasi drop point');
      return;
    }

    // 3) Cek minimal upload gambar kering & basah
    if (imagePathsKering.length < 2 || imagePathsBasah.length < 2) {
      _showMessage(context, 'Upload minimal 2 foto kering & 2 foto basah');
      return;
    }

    // 4) Tampilkan loading dialog
    isLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [Color(0xFF9AE2FF), Color(0xFFF9E071), Color(0xFFF29753)],
            strokeWidth: 2,
          ),
        ),
      ),
    );

    try {
      // 5) Ambil atau buat user (anonim jika belum login)
      final user = await _getUser();

      // 6) Upload gambar kering & basah ke Firebase Storage
      final urlsKering = await _uploadImages(user, imagePathsKering, 'kering');
      final urlsBasah = await _uploadImages(user, imagePathsBasah, 'basah');

      // 7) Simpan data laporan ke Firestore
      await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .add({
        'userId': user.uid,
        'lokasi': selectedLocation,
        'alamat': selectedAddress,
        'plat_nomor': platController.text.trim(),
        'berat_keseluruhan': beratKeseluruhanController.text.trim(),
        'berat_kering': beratKeringController.text.trim(),
        'berat_basah': beratBasahController.text.trim(),
        'catatan': catatanController.text.trim(),
        'images_kering': urlsKering,
        'images_basah': urlsBasah,
        'created_at': FieldValue.serverTimestamp(),
      });

      // 8) Tutup loading dialog & navigasi ke halaman sukses
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SuccesScreen()),
      );
    } catch (e) {
      // Kalau error, tutup dialog & tampilkan pesan
      Navigator.of(context).pop();
      _showMessage(context, 'Gagal menyimpan data: $e');
    }

    isLoading = false; // Reset flag loading
  }

  /// Dapatkan user yang sedang login, atau sign-in anon jika belum ada
  Future<User> _getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) return user;
    final cred = await FirebaseAuth.instance.signInAnonymously();
    return cred.user!;
  }

  /// Upload list file path ke Storage, kembalikan list URL
  Future<List<String>> _uploadImages(
      User user, List<String> paths, String folder) async {
    final urls = <String>[];
    for (var path in paths) {
      final file = File(path);
      // Simpan di folder laporan/[uid]/[folder]/timestamp_filename
      final ref = FirebaseStorage.instance.ref(
        'laporan/${user.uid}/$folder/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}',
      );
      final task = await ref.putFile(file); // Upload file
      urls.add(await task.ref.getDownloadURL()); // Ambil URL
    }
    return urls;
  }

  /// Tampilkan Snackbar di bawah layar
  void _showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  /// Dispose semua TextEditingController
  void disposeAll() {
    platController.dispose();
    beratKeseluruhanController.dispose();
    beratKeringController.dispose();
    beratBasahController.dispose();
    catatanController.dispose();
  }

  /// Load data untuk edit form dari Firestore
  Future<void> loadDataForEdit(String documentId) async {
    final doc = await FirebaseFirestore.instance
        .collection('laporan_pengangkutan')
        .doc(documentId)
        .get();
    if (doc.exists) {
      final data = doc.data()!;
      // Set nilai ke masing-masing controller
      platController.text = data['plat_nomor'] ?? '';
      beratKeringController.text = data['berat_kering']?.toString() ?? '';
      beratBasahController.text = data['berat_basah']?.toString() ?? '';
      catatanController.text = data['catatan'] ?? '';
      selectedLocation = data['lokasi'];
      selectedAddress = data['alamat'];
      _updateTotal(() {}); // Update total berat setelah load
    }
  }
}
