import 'dart:io';
import 'package:bersihku/const.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/form_field_row.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/form_section.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/image_placeholder.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/location_dropdown.dart';
import 'package:bersihku/ui/user-front/succes-screen/succes_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

class InputFormBody extends StatefulWidget {
  const InputFormBody({super.key});

  @override
  State<InputFormBody> createState() => _InputFormBodyState();
}

class _InputFormBodyState extends State<InputFormBody> {
  final _formKey = GlobalKey<FormState>();
  final platController = TextEditingController();
  final beratKeseluruhanController = TextEditingController();
  final beratKeringController = TextEditingController();
  final beratBasahController = TextEditingController();
  final catatanController = TextEditingController();
  String? selectedLocation;
  String? selectedAddress;

  final List<String> imagePathsKering = [];
  final List<String> imagePathsBasah = [];

  final _formatter = NumberFormat('#,##0', 'id_ID');

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    beratKeringController.addListener(_updateTotalBerat);
    beratBasahController.addListener(_updateTotalBerat);
  }

  void _updateTotalBerat() {
    final beratKering = double.tryParse(beratKeringController.text) ?? 0;
    final beratBasah = double.tryParse(beratBasahController.text) ?? 0;
    final total = beratKering + beratBasah;

    beratKeseluruhanController.text = _formatter.format(total).replaceAll(',00', '');
  }

  Future<void> _submitForm() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tolong lengkapi semua bidang')),
      );
      return;
    }

    if (selectedLocation == null || selectedLocation!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih lokasi drop point')),
      );
      return;
    }

    if (imagePathsKering.length < 2 || imagePathsBasah.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload minimal 2 foto kering & 2 foto basah')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

   showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => Center(
    child: SizedBox(
      height: 50,
      width: 50,
      child: const LoadingIndicator(
        indicatorType: Indicator.ballPulse,
        colors: [Color(0xFF9AE2FF), Color(0xFFF9E071), Color(0xFFF29753)],
        strokeWidth: 2,
      ),
    ),
  ),
);

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        final cred = await FirebaseAuth.instance.signInAnonymously();
        user = cred.user;
      }

      List<String> urlsKering = [];
      for (var path in imagePathsKering) {
        final file = File(path);
        final ref = FirebaseStorage.instance.ref(
            'laporan/${user!.uid}/kering/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}');
        final task = await ref.putFile(file);
        urlsKering.add(await task.ref.getDownloadURL());
      }

      List<String> urlsBasah = [];
      for (var path in imagePathsBasah) {
        final file = File(path);
        final ref = FirebaseStorage.instance.ref(
            'laporan/${user!.uid}/basah/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}');
        final task = await ref.putFile(file);
        urlsBasah.add(await task.ref.getDownloadURL());
      }

      await FirebaseFirestore.instance.collection('laporan_pengangkutan').add({
        'userId': user!.uid,
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

      Navigator.of(context).pop(); // Close loading dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SuccesScreen()),
      );
    } catch (e) {
      debugPrint('ERROR _submitForm: $e');
      Navigator.of(context).pop(); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    platController.dispose();
    beratKeseluruhanController.dispose();
    beratKeringController.dispose();
    beratBasahController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 15),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Pilih Lokasi Drop Point',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            LocationDropdown(
              onChanged: (lokasi, alamat) {
                setState(() {
                  selectedLocation = lokasi;
                  selectedAddress = alamat;
                });
              },
              validator: (value) => value == null ? 'Lokasi wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            FieldWithLabel(
              label: 'Nomor Plat Truk',
              controller: platController,
              spacing: 93,
              validator: (val) =>
                  val == null || val.isEmpty ? 'Harus diisi' : null,
              isPlate: true,
            ),
            const SizedBox(height: 16),
            FieldWithLabel(
              label: 'Total Berat Keseluruhan',
              controller: beratKeseluruhanController,
              spacing: 40,
              suffixText: 'Kg',
              readOnly: true,
              validator: (val) =>
                  val == null || val.isEmpty ? 'Harus diisi' : null,
            ),
            const SizedBox(height: 24),
            const FormSectionTitle(
                title: 'Sampah Kering', color: secondaryColor),
            const SizedBox(height: 16),
            FieldWithLabel(
              label: 'Total Berat',
              controller: beratKeringController,
              spacing: 130,
              suffixText: 'Kg',
              validator: (val) =>
                  val == null || val.isEmpty ? 'Harus diisi' : null,
            ),
            const SizedBox(height: 16),
            UploadImagePlaceholder(
              title: 'Foto Sampah Sebelum Diangkut',
              validator: (val) => null,
              onImagesChanged: (paths) => setState(() {
                imagePathsKering.addAll(paths.map((e) => e['path']!));
              }),
            ),
            const SizedBox(height: 20),
            UploadImagePlaceholder(
              title: 'Foto Sampah Sesudah Diangkut',
              validator: (val) => null,
              onImagesChanged: (paths) => setState(() {
                imagePathsKering.addAll(paths.map((e) => e['path']!));
              }),
            ),
            const SizedBox(height: 24),
            const FormSectionTitle(title: 'Sampah Basah', color: Colors.orange),
            const SizedBox(height: 16),
            FieldWithLabel(
              label: 'Total Berat',
              controller: beratBasahController,
              spacing: 130,
              suffixText: 'Kg',
              validator: (val) =>
                  val == null || val.isEmpty ? 'Harus diisi' : null,
            ),
            const SizedBox(height: 16),
            UploadImagePlaceholder(
              title: 'Foto Sampah Sebelum Diangkut',
              validator: (val) => null,
              onImagesChanged: (paths) => setState(() {
                imagePathsBasah.addAll(paths.map((e) => e['path']!));
              }),
            ),
            const SizedBox(height: 20),
            UploadImagePlaceholder(
              title: 'Foto Sampah Sesudah Diangkut',
              validator: (val) => null,
              onImagesChanged: (paths) => setState(() {
                imagePathsBasah.addAll(paths.map((e) => e['path']!));
              }),
            ),
            const SizedBox(height: 24),
            const Text(
              'Catatan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: catatanController,
                expands: true,
                maxLines: null,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tambahkan Catatan',
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: secondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
                child: const Text('Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}