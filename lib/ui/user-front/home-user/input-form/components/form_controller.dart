import 'dart:io';
import 'package:bersihku/ui/user-front/succes-screen/succes_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_indicator/loading_indicator.dart';

class InputFormController {
  final formKey = GlobalKey<FormState>();
  final platController = TextEditingController();
  final beratKeseluruhanController = TextEditingController();
  final beratKeringController = TextEditingController();
  final beratBasahController = TextEditingController();
  final catatanController = TextEditingController();

  String? selectedLocation;
  String? selectedAddress;
  bool isLoading = false;

  final List<String> imagePathsKering = [];
  final List<String> imagePathsBasah = [];

  final formatter = NumberFormat('#,##0', 'id_ID');

  void initListener(VoidCallback onChanged) {
    beratKeringController.addListener(() => _updateTotal(onChanged));
    beratBasahController.addListener(() => _updateTotal(onChanged));
  }

  void _updateTotal(VoidCallback onChanged) {
    final kering = double.tryParse(beratKeringController.text) ?? 0;
    final basah = double.tryParse(beratBasahController.text) ?? 0;
    beratKeseluruhanController.text = formatter.format(kering + basah).replaceAll(',00', '');
    onChanged();
  }

  void addImagesKering(List<Map<String, String>> images) {
    imagePathsKering.addAll(images.map((e) => e['path']!));
  }

  void addImagesBasah(List<Map<String, String>> images) {
    imagePathsBasah.addAll(images.map((e) => e['path']!));
  }

  Future<void> submitForm(BuildContext context) async {
    if (isLoading) return;

    if (!formKey.currentState!.validate()) {
      _showMessage(context, 'Tolong lengkapi semua bidang');
      return;
    }

    if (selectedLocation == null || selectedAddress == null) {
      _showMessage(context, 'Pilih lokasi drop point');
      return;
    }

    if (imagePathsKering.length < 2 || imagePathsBasah.length < 2) {
      _showMessage(context, 'Upload minimal 2 foto kering & 2 foto basah');
      return;
    }

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
      final user = await _getUser();
      final urlsKering = await _uploadImages(user, imagePathsKering, 'kering');
      final urlsBasah = await _uploadImages(user, imagePathsBasah, 'basah');

      await FirebaseFirestore.instance.collection('laporan_pengangkutan').add({
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

      Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SuccesScreen()));
    } catch (e) {
      Navigator.of(context).pop();
      _showMessage(context, 'Gagal menyimpan data: $e');
    }

    isLoading = false;
  }

  Future<User> _getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) return user;
    final cred = await FirebaseAuth.instance.signInAnonymously();
    return cred.user!;
  }

  Future<List<String>> _uploadImages(User user, List<String> paths, String folder) async {
    final urls = <String>[];
    for (var path in paths) {
      final file = File(path);
      final ref = FirebaseStorage.instance.ref(
        'laporan/${user.uid}/$folder/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}',
      );
      final task = await ref.putFile(file);
      urls.add(await task.ref.getDownloadURL());
    }
    return urls;
  }

  void _showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void disposeAll() {
    platController.dispose();
    beratKeseluruhanController.dispose();
    beratKeringController.dispose();
    beratBasahController.dispose();
    catatanController.dispose();
  }

  Future<void> loadDataForEdit(String documentId) async {
    final doc = await FirebaseFirestore.instance.collection('laporan_pengangkutan').doc(documentId).get();
    if (doc.exists) {
      final data = doc.data()!;
      platController.text = data['plat'] ?? '';
      beratKeringController.text = data['beratKering']?.toString() ?? '';
      beratBasahController.text = data['beratBasah']?.toString() ?? '';
      catatanController.text = data['catatan'] ?? '';
      selectedLocation = data['lokasi'];
      selectedAddress = data['alamat'];
      _updateTotal(() {}); // update berat keseluruhan
    }
  }
}
