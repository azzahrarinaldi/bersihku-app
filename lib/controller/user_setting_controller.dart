import 'dart:io';
import 'package:bersihku/ui/admin/home-admin/home-screen-admin/admin_home_screen.dart';
import 'package:bersihku/ui/user/home-user/home-screen-user/user_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserSettingController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);
  final RxString profileImageUrl = ''.obs;

  final picker = ImagePicker();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;

  String role = 'user'; // default

  @override
  void onInit() {
    super.onInit();
    fetchProfileImage();
    loadUserProfile();
  }

  Future<void> fetchProfileImage() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      profileImageUrl.value = doc.data()?['profile_picture'] ?? '';
    } catch (_) {
      profileImageUrl.value = '';
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
      if (uid == null || imageFile.value == null) return;
      final ref =
          FirebaseStorage.instance.ref().child('profile_pictures/$uid.jpg');
      await ref.putFile(imageFile.value!);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'profile_picture': url});
      profileImageUrl.value = url;
    } catch (_) {}
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
    passwordController.clear();

    role = data['role'] ?? 'user';
  }

  Future<void> saveUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    isLoading.value = true;
    try {
      final newName = nameController.text.trim();
      final newPhone = phoneController.text.trim();
      final newEmail = emailController.text.trim();
      final newPassword = passwordController.text.trim();

      // Update Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'name': newName,
        'phone': newPhone,
        'email': newEmail,
      });

      // Update Auth if needed
      if (newPassword.isNotEmpty) {
        await user.updatePassword(newPassword);
      }
      if (user.email != newEmail) {
        // ignore: deprecated_member_use
        await user.updateEmail(newEmail);
      }

      Get.snackbar(
        'Sukses',
        'Profil berhasil diperbarui',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );

      // Redirect based on role
     if (role.trim().toLowerCase() == 'admin') {
        Get.offAll(() => AdminHomeScreen());
      } else if (role.trim().toLowerCase() == 'user') {
        Get.offAll(() => UserHomeScreen());
      } else {
        // fallback kalau role tidak dikenali
        Get.snackbar(
          'Error',
          'Role tidak dikenali: $role',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      final msg = e.code == 'requires-recent-login'
          ? 'Silakan login ulang untuk mengubah data.'
          : e.message ?? 'Error Auth';
      Get.snackbar('Error', msg,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyimpan profil: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      passwordController.clear();
    }
  }

  Future<void> deleteProfileImage() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;
      final ref =
          FirebaseStorage.instance.ref().child('profile_pictures/$uid.jpg');
      await ref.delete();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'profile_picture': ''});
      profileImageUrl.value = '';
      Get.snackbar('Sukses', 'Foto profil berhasil dihapus',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4EBAE5),
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Tidak bisa menghapus foto: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
