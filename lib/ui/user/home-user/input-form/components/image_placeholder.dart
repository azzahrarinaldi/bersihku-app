import 'dart:io';
import 'package:bersihku/services/location_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // compute()
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:image/image.dart' as img;
import 'package:bersihku/ui/user/home-user/input-form/components/submit-image/image_picker_logic.dart';

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
      final path = await ImagePickerLogic.pickImage();
      if (path == null || !mounted) return;

      final file = File(path);
      final raw = await file.readAsBytes();

      final now = DateTime.now();
      final timestamp =
          '${_twoDigits(now.day)}-${_twoDigits(now.month)}-${now.year} ${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';

      // Ambil nama petugas dari Firestore, bukan displayName
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      final petugas = doc.data()?['name'] ?? '[Unknown]';

      final lokasi = await LocationService.getLocationText();

      // Proses stamping di isolate
      final result = await compute(_processImage, {
        'raw': raw,
        'timestamp': timestamp,
        'petugas': petugas,
        'lokasi': lokasi,
        'path': path,
      });

      final filename = result['filename'] as String;
      final bytes = result['bytes'] as List<int>;

      final outPath = '${file.parent.path}/$filename';
      await File(outPath).writeAsBytes(bytes);

      setState(() {
        _imagePaths.add({
          'path': outPath,
          'timestamp': now.toIso8601String(),
        });
      });
      widget.onImagesChanged(_imagePaths);
    } catch (e, st) {
      debugPrint('Error in _pickImage: $e');
      debugPrint(st.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  static Future<Map<String, dynamic>> _processImage(
      Map<String, dynamic> args) async {
    final raw = args['raw'] as List<int>;
    final timestamp = args['timestamp'] as String;
    final petugas = args['petugas'] as String;
    final lokasi = args['lokasi'] as String;
    final path = args['path'] as String;

    img.Image? image = img.decodeImage(Uint8List.fromList(raw));
    if (image == null) throw 'Gagal decode gambar';

    final font = img.arial_48;
    final color = img.getColor(0, 255, 0);
    const pad = 40;
    final lineHeight = font.lineHeight + 2;
    final baseY = image.height - pad - lineHeight * 4;

    img.drawString(image, font, pad, baseY + lineHeight * 0, timestamp, color: color);
    img.drawString(image, font, pad, baseY + lineHeight * 1, petugas, color: color);

    String loc1 = lokasi.length > 50 ? lokasi.substring(0, 50) + '...' : lokasi;
    String loc2 = lokasi.length > 100 ? lokasi.substring(50, 100) + '...' : '';

    img.drawString(image, font, pad, baseY + lineHeight * 2, loc1, color: color);
    if (loc2.isNotEmpty) {
      img.drawString(image, font, pad, baseY + lineHeight * 3, loc2, color: color);
    }

    List<int> compressed;
    int quality = 85;
    do {
      compressed = img.encodeJpg(image, quality: quality);
      quality -= 5;
    } while (compressed.length > 300 * 1024 && quality > 10);

    return {
      'bytes': compressed,
      'filename': 'stamped_${path.split('/').last}',
    };
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
