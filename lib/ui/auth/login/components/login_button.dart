import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bersihku/ui/auth/admin.dart';
import 'package:bersihku/ui/auth/user.dart';

class LoginButton extends StatelessWidget {
  final bool isFormFilled;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    Key? key,
    required this.isFormFilled,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFormFilled ? Colors.blue : Color(0xFFA6A6A6),
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
                          MaterialPageRoute(builder: (context) => const AdminScreen()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const UserScreen()),
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
