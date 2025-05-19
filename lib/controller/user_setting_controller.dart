import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSettingController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);
  final RxString profileImageUrl = ''.obs;

  final ImagePicker picker = ImagePicker();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileImage();
  }

  Future<void> fetchProfileImage() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final url = doc.data()?['profile_picture'] ?? '';
      profileImageUrl.value =
          url.isNotEmpty ? url : 'assets/images/profile-person-history.png';
    } catch (e) {
      print("Error: $e");
      profileImageUrl.value = 'assets/images/profile-person-history.png';
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      imageFile.value = File(picked.path);
      await uploadImage();
    }
  }

  Future<void> uploadImage() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final ref =
          FirebaseStorage.instance.ref().child('profile_pictures/$uid.jpg');
      await ref.putFile(imageFile.value!);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profile_picture': url,
      });
      profileImageUrl.value = url;
    } catch (e) {
      print("Upload Error: $e");
    }
  }

  Future<void> loadUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return;
    final data = doc.data()!;

    nameController.text = data['name'] ?? '';
    phoneController.text = data['phone'] ?? '';
    emailController.text = data['email'] ?? '';
    // Password tidak diambil
  }

  Future<void> saveUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
      });

      Get.snackbar(
        "Sukses",
        "Profil berhasil diperbarui",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF4EBAE5),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        icon: const Icon(Icons.check_circle, color: Colors.white),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Error", "Gagal menyimpan profil: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF4EBAE5),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProfileImage() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      // Hapus file dari Firebase Storage
      final ref =
          FirebaseStorage.instance.ref().child('profile_pictures/$uid.jpg');
      await ref.delete();

      // Update Firestore (hapus URL)
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profile_picture': '',
      });

      // Set default gambar lokal
      profileImageUrl.value = 'assets/images/profile-person-history.png';

      Get.snackbar(
        "Sukses",
        "Foto profil berhasil dihapus",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF4EBAE5),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        icon: const Icon(Icons.check_circle, color: Colors.white),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      print("Delete Error: $e");
      Get.snackbar(
        "Gagal",
        "Tidak bisa menghapus foto: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF4EBAE5),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );
    }
  }
}


