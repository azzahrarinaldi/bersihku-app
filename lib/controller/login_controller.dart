import 'package:bersihku/ui/admin/home-admin/home-screen-admin/admin_home_screen.dart';
import 'package:bersihku/ui/user/home-user/home-screen-user/user_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
   // Controller untuk mengambil input email dan password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Reactive boolean dari GetX, untuk cek apakah form sudah diisi
  var isFormFilled = false.obs;

  @override
  void onInit() {
    super.onInit();
     // Setiap kali teks berubah, cek ulang apakah form sudah terisi
    emailController.addListener(_updateFormState);
    passwordController.addListener(_updateFormState);
  }

  // Fungsi untuk update status form apakah sudah terisi
  void _updateFormState() {
    isFormFilled.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  // Fungsi untuk login dengan email & password
  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

     // Login ke Firebase Auth
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

       // Ambil UID dari user yang login.
      final uid = userCredential.user?.uid;

      if (uid != null) {
         // Ambil dokumen user dari koleksi Firestore berdasarkan UID.
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

          // Cek apakah data user ditemukan di database.
        if (userDoc.exists) {
           // Ambil data role (admin atau user).
          final role = userDoc.data()?['role'];

          // ✅ Tampilkan Snackbar sukses
          Get.snackbar(
            'Sukses',
            'Berhasil login',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color.fromARGB(255, 22, 192, 113),
            colorText: Colors.white
          );

            // Arahkan user ke halaman sesuai dengan rolenya.
          if (role == 'admin') {
            Get.offAll(() => const AdminHomeScreen());
          } else {
            Get.offAll(() => const UserHomeScreen());
          }
        } else {
           // Jika dokumen tidak ditemukan, tampilkan error.
          Get.snackbar(
            "Error",
            "User data not found",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // Tangani error dari Firebase Auth seperti password salah, email tidak ditemukan, dll.
      String errorMsg = 'Login gagal';
      if (e.code == 'user-not-found') {
        errorMsg = 'Email tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Password salah';
      }
      // Tampilkan pesan error di snackbar
      Get.snackbar(
        "Error",
        errorMsg,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

   // Fungsi login menggunakan akun Google
  Future<void> signInWithGoogle() async {
    try {
      // Buka popup akun Google untuk login.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
       // 3. Ambil token autentikasi dari akun Google yang sudah login
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // 4. Buat credential Firebase dari token Google tadi
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

        // 5. Gunakan credential untuk login ke Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // 6. Ambil UID user yang sudah login
      final uid = userCredential.user?.uid;

       // 7. Cek apakah user sudah punya data di Firestore
      if (uid != null) {
         // Ambil dokumen user dari Firestore berdasarkan UID yang didapat dari Firebase Auth
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

          // Cek apakah dokumen user tersebut ada di Firestore
        if (userDoc.exists) {
          // Ambil nilai 'role' dari data user (misal 'admin' atau 'user')
          final role = userDoc.data()?['role'];

          // Tampilkan snackbar sebagai tanda login berhasil
          Get.snackbar(
            'Sukses',
            'Berhasil login dengan Google',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color.fromARGB(255, 22, 192, 113),
            colorText: Colors.white,
          );

           // Berdasarkan role user, navigasi ke halaman yang sesuai
          if (role == 'admin') {
            // Kalau role admin, pindah ke halaman AdminHomeScreen
            Get.offAll(() => const AdminHomeScreen());
            // Kalau bukan admin, pindah ke halaman UserHomeScreen (user biasa)
          } else {
            Get.offAll(() => const UserHomeScreen());
          }
        // Jika dokumen user tidak ditemukan di Firestore
        } else {
          Get.snackbar(
            "Error",
            "User data not found",
            colorText: Colors.black,
          );
        }
      }
      //error handler jika login google gagal di karenakan jaringan dan token tidak balik
    } catch (e) {
      Get.snackbar(
        "Google Sign-In Error",
        e.toString(),
        colorText: Colors.black,
      );
    }
  }
}
