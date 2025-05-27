import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  // Digunakan untuk memvalidasi form input
  final formKey = GlobalKey<FormState>();

  // Controller untuk mengambil input dari TextFormField
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // FocusNode agar bisa mengatur focus dari field password
  final passwordFocusNode = FocusNode();

   // State untuk toggle password visible (true/false)
  final isPasswordVisible = false.obs;

  // State untuk cek apakah form valid atau tidak
  final isFormValid = false.obs;

    // Fungsi untuk memeriksa kekuatan password
  bool isPasswordStrong(String password) => password.length >= 8;

   // Fungsi untuk menampilkan/menyembunyikan password
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Fungsi untuk validasi form ketika user mengetik input
  void validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    isFormValid.value = isValid;
  }

  // Fungsi utama untuk mendaftarkan user baru
  Future<void> registerUser() async {
    if (!isFormValid.value) {
      Get.snackbar('Error', 'Form tidak valid, cek inputan kamu',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      // Mendaftarkan user ke Firebase Authentication
      final cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = cred.user;

      //jika registrasi berhasil
      if (user != null) {
         // Simpan data tambahan user ke Firestore (termasuk password untuk keperluan tertentu)
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'email': emailController.text.trim(),
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'role': 'user',
          'created_at': FieldValue.serverTimestamp(),
        });
        
        // Logout user setelah register agar login ulang secara manual
        await FirebaseAuth.instance.signOut();

        // Tampilkan notifikasi sukses
        Get.snackbar('Sukses', 'Registrasi berhasil! Silakan login.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color.fromARGB(255, 22, 192, 113),
            colorText: Colors.white);

        // Navigasi ke halaman login
        Get.offAll(() => const LoginScreen());
      }

      // Tangani error spesifik dari Firebase
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Registrasi gagal', e.message ?? 'Error saat registrasi',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Fungsi untuk login atau register menggunakan akun Google
  Future<void> signInWithGoogle() async {
    try {
       // Tampilkan popup untuk pilih akun Google
      final googleUser = await GoogleSignIn().signIn();

       // Jika user batal pilih akun
      if (googleUser == null) {
        Get.snackbar('Batal', 'Login dengan Google dibatalkan',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
      
      // Ambil token dari akun Google
      final googleAuth = await googleUser.authentication;

      // Buat credential dari Google
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login ke Firebase menggunakan credential dari Google
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
         // Cek apakah data user sudah ada di Firestore
        final userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);
        final snapshot = await userDoc.get();

          // Jika belum ada, tambahkan data user
        if (!snapshot.exists) {
          await userDoc.set({
            'email': user.email ?? '',
            'password': '',
            'name': user.displayName ?? '',
            'phone': user.phoneNumber ?? '',
            'role': 'user',
            'created_at': FieldValue.serverTimestamp(),
          });
        }

        Get.snackbar(
          'Sukses',
          'Berhasil daftar/login dengan Google!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color.fromARGB(255, 22, 192, 113),
          colorText: Colors.white,
        );

         // jika berhasil maka arahkan ke halaman login (karena alur register Google ingin diperlakukan sama)
        Get.offAll(LoginScreen());

      }
    } catch (e) {
      Get.snackbar('Gagal login Google', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onClose() {
     // Bersihkan semua controller dan focus node saat controller tidak lagi digunakan
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
