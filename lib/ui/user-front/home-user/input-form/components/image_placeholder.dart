import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UploadImagePlaceholder extends StatefulWidget {
  final String title;

  const UploadImagePlaceholder({Key? key, required this.title})
      : super(key: key);

  @override
  State<UploadImagePlaceholder> createState() => _UploadImagePlaceholderState();
}

class _UploadImagePlaceholderState extends State<UploadImagePlaceholder> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImage(); // Ini PENTING supaya gambar tetap
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPath = prefs.getString('saved_image');

    if (savedPath != null && mounted) {
      setState(() {
        _imagePath = savedPath;
      });
    }
  }

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
                  ? Image.file(
                      File(_imagePath!),
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    )
                  : Image.asset(
                      'assets/images/tambah-foto.png',
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
