import 'package:image_picker/image_picker.dart';

class ImagePickerLogic {
  static Future<String?> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera, // langsung buka kamera
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 85, // biar size gak terlalu besar
    );
    return pickedFile?.path;
  }
}
