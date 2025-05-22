import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final passwordFocusNode = FocusNode();
  final isPasswordVisible = false.obs;

  final isFormValid = false.obs;

  bool isPasswordStrong(String password) => password.length >= 8;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    isFormValid.value = isValid;
  }

  Future<void> registerUser() async {
    if (!isFormValid.value) {
      Get.snackbar('Error', 'Form tidak valid, cek inputan kamu',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = cred.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': emailController.text.trim(),
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'role': 'user',
          'created_at': FieldValue.serverTimestamp(),
        });
        
       

        Get.snackbar('Sukses', 'Registrasi berhasil! Silakan login.',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.green, colorText: Colors.white);

        Get.offAll(() => LoginScreen()); 
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Registrasi gagal', e.message ?? 'Error saat registrasi',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar('Batal', 'Login dengan Google dibatalkan',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final snapshot = await userDoc.get();

        if (!snapshot.exists) {
          await userDoc.set({
            'email': user.email ?? '',
            'name': user.displayName ?? '',
            'phone': user.phoneNumber ?? '',
            'role': 'user',
            'created_at': FieldValue.serverTimestamp(),
          });
        }

        Get.snackbar('Sukses', 'Berhasil daftar/login dengan Google!',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.green, colorText: Colors.white);

        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.snackbar('Gagal login Google', e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
