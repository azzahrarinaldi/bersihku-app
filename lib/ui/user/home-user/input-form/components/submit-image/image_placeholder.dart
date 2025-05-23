import 'dart:io';

import 'package:bersihku/handler/image_picker_services.dart';
import 'package:bersihku/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // for compute()
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
  _UploadImagePlaceholderState createState() => _UploadImagePlaceholderState();
}

class _UploadImagePlaceholderState extends State<UploadImagePlaceholder> {
  List<Map<String, String>> _imagePaths = [];
  bool _isLoading = false;

  Future<void> _pickImage() async {
    setState(() => _isLoading = true);
    try {
      final path = await ImagePickerServices.pickImage();
      if (path == null || !mounted) return;

      final file = File(path);
      final raw = await file.readAsBytes();

      final now = DateTime.now();
      final timestamp =
          '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${now.year} ${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';

      final user = FirebaseAuth.instance.currentUser;
      final petugas = user?.displayName ?? '[Unknown]';
      final lokasi = await LocationService.getLocationText();

      final result = await compute(processImageInIsolate, {
        'raw': raw,
        'timestamp': timestamp,
        'petugas': petugas,
        'lokasi': lokasi,
        'path': path,
      });

      final filename = result['filename'];
      final bytes = result['bytes'];

      final outPath = '${file.parent.path}/$filename';
      final outFile = await File(outPath).writeAsBytes(bytes);

      setState(() {
        _imagePaths.add({'path': outFile.path, 'timestamp': now.toIso8601String()});
        _isLoading = false;
      });

      widget.onImagesChanged(_imagePaths);
    } catch (e, st) {
      debugPrint('Error in _pickImage: $e');
      debugPrint(st.toString());
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
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Gambar harus dipilih',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        if (_isLoading)
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: const LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [Color(0xFF9AE2FF), Color(0xFFF9E071), Color(0xFFF29753)],
              strokeWidth: 2,
            ),
          ),
      ],
    );
  }
}