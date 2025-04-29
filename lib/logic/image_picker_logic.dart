import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerLogic {
  // Fungsi untuk memilih gambar dari kamera dengan timestamp
  static Future<String?> pickImage() async {
    final picker = ImagePicker();
    
    // Mengambil gambar dari kamera
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '$timestamp.jpg'; // Nama file menggunakan timestamp
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
      
      return savedImage.path; // Mengembalikan path gambar yang telah disimpan
    }
    return null;
  }
}
