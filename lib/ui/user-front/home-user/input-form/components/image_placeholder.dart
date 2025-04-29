import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UploadImagePlaceholder extends StatefulWidget {
  final String title;
  final String? Function(String?)? validator; // Validator untuk gambar

  const UploadImagePlaceholder({Key? key, required this.title, this.validator})
      : super(key: key);

  @override
  State<UploadImagePlaceholder> createState() => _UploadImagePlaceholderState();
}

class _UploadImagePlaceholderState extends State<UploadImagePlaceholder> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImage(); // Load gambar yang disimpan
  }

  // Fungsi untuk memuat gambar yang sudah dipilih sebelumnya
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPath = prefs.getString('saved_image');

    if (savedPath != null && mounted) {
      setState(() {
        _imagePath = savedPath;
      });
    }
  }

  // Fungsi untuk memilih gambar
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_image', savedImage.path);

      if (mounted) {
        setState(() {
          _imagePath = savedImage.path;
        });
      }
    }
  }

  // Fungsi untuk membuka gambar di layar penuh
  void _openFullImage(BuildContext context) {
    if (_imagePath != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Image.file(
              File(_imagePath!),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _imagePath != null
                  ? GestureDetector(
                      onTap: () => _openFullImage(context),
                      child: Image.file(
                        File(_imagePath!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/images/tambah-foto.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        if (widget.validator != null && _imagePath == null)
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
