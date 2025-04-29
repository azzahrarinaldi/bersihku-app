import 'package:bersihku/logic/image_picker_logic.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class UploadImagePlaceholder extends StatefulWidget {
  final String title;
  final String? Function(String?)? validator;

  const UploadImagePlaceholder({Key? key, required this.title, this.validator})
      : super(key: key);

  @override
  _UploadImagePlaceholderState createState() => _UploadImagePlaceholderState();
}

class _UploadImagePlaceholderState extends State<UploadImagePlaceholder> {
  List<Map<String, String>> _imagePaths = []; // Menyimpan path + timestamp

  // Fungsi pilih gambar
  Future<void> _pickImage() async {
    String? path = await ImagePickerLogic.pickImage();
    if (path != null && mounted) {
      String timestamp = DateTime.now().toString();

      final imageFile = File(path);
      final img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

      if (image != null) {
        final text = DateTime.now().millisecondsSinceEpoch.toString();
        final font = img.arial_24;
        final color = img.getColor(255, 0, 0);

        img.drawString(image, font, 10, 10, text, color: color);

        final newImagePath = '${imageFile.parent.path}/fl$text.jpg';
        final newImageFile = File(newImagePath)
          ..writeAsBytesSync(img.encodeJpg(image));

        setState(() {
          _imagePaths.add({
            'path': newImagePath,
            'timestamp': timestamp,
          });
        });
      }
    }
  }

  // Buka gambar full
  void _openFullImage(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Hapus gambar
  void _removeImage(String imagePath) {
    setState(() {
      _imagePaths.removeWhere((item) => item['path'] == imagePath);
    });
  }

  // Format tanggal
  String _formatDate(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    return '${dateTime.day} ${_monthName(dateTime.month)} ${dateTime.year}';
  }

  // Format waktu
  String _formatTime(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    return '${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}:${_twoDigits(dateTime.second)}';
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
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
            // Tombol tambah foto
            GestureDetector(
              onTap: _pickImage,
              child: SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/tambah-foto.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Gambar upload + timestamp
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _imagePaths.map((imageData) {
                    final imagePath = imageData['path']!;
                    final timestamp = imageData['timestamp']!;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () => _openFullImage(context, imagePath),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(imagePath),
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 100,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeImage(imagePath),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_formatDate(timestamp)}    |    ${_formatTime(timestamp)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        if (widget.validator != null && _imagePaths.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Gambar harus dipilih',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
