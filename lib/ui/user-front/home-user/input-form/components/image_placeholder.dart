import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagePlaceholder extends StatefulWidget {
  final String title;

  const UploadImagePlaceholder({Key? key, required this.title})
      : super(key: key);

  @override
  State<UploadImagePlaceholder> createState() => _UploadImagePlaceholderState();
}

class _UploadImagePlaceholderState extends State<UploadImagePlaceholder> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery); // atau .camera

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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
          child: _image != null
              ? Image.file(_image!, fit: BoxFit.cover)
              : Image.asset('assets/images/tambah-foto.png', fit: BoxFit.contain),
        ),
      ],
    );
  }
}
