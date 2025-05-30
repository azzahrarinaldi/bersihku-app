// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:bersihku/services/location_service.dart';
import 'package:bersihku/ui/user/home-user/input-form/components/submit-image/image_picker_logic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'image_processing.dart';

class UploadImagePlaceholder extends StatefulWidget {
  final String title;
  final String? Function(String?)? validator;
  final void Function(List<Map<String, String>>) onImagesChanged;

  const UploadImagePlaceholder({
    super.key,
    required this.title,
    this.validator,
    required this.onImagesChanged,
  });

  @override
  State<UploadImagePlaceholder> createState() => _UploadImagePlaceholderState();
}

class _UploadImagePlaceholderState extends State<UploadImagePlaceholder> {
  final List<Map<String, String>> _imagePaths = [];
  bool _isLoading = false;

  Future<void> _pickImage() async {
    setState(() => _isLoading = true);
    try {
      final path = await ImagePickerServices.pickImage(context);
      if (path == null || !mounted) {
        setState(() => _isLoading = false);
        return;
      }

      final file = File(path);
      final raw = await file.readAsBytes();

      final now = DateTime.now();
      final timestamp =
          '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${now.year} '
          '${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User belum login';

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final petugasName = doc.data()?['name'] as String? ?? '[Unknown]';

      final lokasiText =
          await LocationService.getLocationText(timeout: const Duration(seconds: 5));

      final result = await processImageOptimized(
        raw: raw,
        timestamp: timestamp,
        petugas: petugasName,
        lokasi: lokasiText,
        path: path,
      );

      final filename = result['filename'] as String;
      final bytes = result['bytes'] as List<int>;
      final outPath = '${file.parent.path}/$filename';
      await File(outPath).writeAsBytes(bytes);

      setState(() {
        _imagePaths.add({'path': outPath, 'timestamp': now.toIso8601String()});
        _isLoading = false;
      });
      widget.onImagesChanged(_imagePaths);
    } catch (e) {
      debugPrint('Error in _pickImage: $e');
      setState(() => _isLoading = false);
    }
  }

  String _twoDigits(int v) => v.toString().padLeft(2, '0');

  void _openFullImage(BuildContext ctx, String p) {
    Navigator.of(ctx).push(MaterialPageRoute(
      builder: (_) => Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () => Navigator.of(ctx).pop(),
          child: Center(child: Image.file(File(p), fit: BoxFit.contain)),
        ),
      ),
    ));
  }

  void _removeImage(String p) {
    setState(() => _imagePaths.removeWhere((e) => e['path'] == p));
    widget.onImagesChanged(_imagePaths);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/tambah-foto.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _imagePaths.map((m) {
                    final p = m['path']!;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () => _openFullImage(context, p),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(p),
                                width: 150,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeImage(p),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        if (widget.validator != null && _imagePaths.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text('Gambar harus dipilih',
                style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
        if (_isLoading)
          const SizedBox(
            height: 50,
            width: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [Color(0xFF9AE2FF), Color(0xFFF9E071), Color(0xFFF29753)],
              strokeWidth: 2,
            ),
          ),
      ],
    );
  }
}
