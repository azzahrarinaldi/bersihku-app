// lib/controller/change_password_controller.dart

import 'package:bersihku/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final oldPassword = ''.obs;
  final newPassword = ''.obs;
  final confirmPassword = ''.obs;
  final isLoading = false.obs;

  // Toggle visibility flags
  final obscureOld = true.obs;
  final obscureNew = true.obs;
  final obscureConfirm = true.obs;

  // Update fields
  void setOldPassword(String val) => oldPassword.value = val;
  void setNewPassword(String val) => newPassword.value = val;
  void setConfirmPassword(String val) => confirmPassword.value = val;

  // Toggle visibility
  void toggleObscureOld() => obscureOld.toggle();
  void toggleObscureNew() => obscureNew.toggle();
  void toggleObscureConfirm() => obscureConfirm.toggle();

  Future<void> changePassword() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final oldPass = oldPassword.value.trim();
    final newPass = newPassword.value.trim();
    final confirmPass = confirmPassword.value.trim();

    // Validate
    if (newPass != confirmPass) {
      Get.snackbar(
        'Error',
        'Password baru dan konfirmasi tidak cocok',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (newPass.length < 6) {
      Get.snackbar(
        'Error',
        'Password baru minimal 6 karakter',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (oldPass.isEmpty) {
      Get.snackbar(
        'Error',
        'Masukkan password lama',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {
      // Reauthenticate
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPass,
      );
      await user.reauthenticateWithCredential(cred);

      // Update password in Auth
      await user.updatePassword(newPass);

      // Sync updated password to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'password': newPass});

      // Show success snackbar
      Get.snackbar(
        'Sukses',
        'Password berhasil diubah',
        snackPosition: SnackPosition.TOP,
        backgroundColor: primaryColor,
        colorText: Colors.white,
      );

      // Delay before navigating back to allow snackbar to show
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.back();
      });

      // Clear fields
      oldPassword.value = '';
      newPassword.value = '';
      confirmPassword.value = '';
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengubah password: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
