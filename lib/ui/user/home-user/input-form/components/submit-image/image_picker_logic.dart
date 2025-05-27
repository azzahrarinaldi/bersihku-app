import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  static Future<String?> pickImage(BuildContext context) async {
    final result = await showModalBottomSheet<ImageSource>(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil dari Kamera'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.red,),
              title: const Text('Batal'),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );

    if (result == null) return null;

    final pickedFile = await ImagePicker().pickImage(
      source: result,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 80, 
    );

    return pickedFile?.path;
  }
}
