import 'package:bersihku/ui/admin-front/home-admin/admin_home_screen.dart';
import 'package:bersihku/ui/user-front/home-user/user_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isFormFilled;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function()? onGoogleSignIn;  // Menambahkan parameter untuk sign-in dengan Google

  const LoginButton({
    super.key,
    required this.isFormFilled,
    required this.emailController,
    required this.passwordController,
    this.onGoogleSignIn,  // Menambahkan parameter onGoogleSignIn
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFormFilled ? Color(0xFF4AB1DA) : Color(0xFFA6A6A6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: isFormFilled
            ? () async {
                try {
                  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );

                  final uid = userCredential.user?.uid;
                  if (uid != null) {
                    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

                    if (userDoc.exists) {
                      final role = userDoc.data()?['role'];

                      if (role == 'admin') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => AdminHomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const UserHomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User data not found')),
                      );
                    }
                  }
                } on FirebaseAuthException catch (e) {
                  String errorMsg = 'Login gagal';
                  if (e.code == 'user-not-found') {
                    errorMsg = 'Email tidak ditemukan';
                  } else if (e.code == 'wrong-password') {
                    errorMsg = 'Password salah';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
                }
              }
            : null,
        child: const Text(
          "Masuk",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
