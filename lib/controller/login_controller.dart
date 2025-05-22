import 'package:bersihku/ui/admin/home-admin/home-screen-admin/admin_home_screen.dart';
import 'package:bersihku/ui/user-front/home-user/home-screen-user/user_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isFormFilled = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_updateFormState);
    passwordController.addListener(_updateFormState);
  }

  void _updateFormState() {
    isFormFilled.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid != null) {
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
          final role = userDoc.data()?['role'];
          if (role == 'admin') {
            Get.offAll(() => const AdminHomeScreen());
          } else {
            Get.offAll(() => const UserHomeScreen());
          }
        } else {
          Get.snackbar("Error", "User data not found",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Login gagal';
      if (e.code == 'user-not-found') {
        errorMsg = 'Email tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Password salah';
      }
      Get.snackbar("Error", errorMsg,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final uid = userCredential.user?.uid;
      if (uid != null) {
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
          final role = userDoc.data()?['role'];
          if (role == 'admin') {
            Get.offAll(() => const AdminHomeScreen());
          } else {
            Get.offAll(() => const UserHomeScreen());
          }
        } else {
          Get.snackbar("Error", "User data not found",
               colorText: Colors.black);
        }
      }
    } catch (e) {
      Get.snackbar("Google Sign-In Error", e.toString(),
          colorText: Colors.black);
    }
  }
}
