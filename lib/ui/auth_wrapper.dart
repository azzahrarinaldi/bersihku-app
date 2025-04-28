import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:bersihku/ui/user-front/home-user/user_home_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Kalau masih loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Kalau user belum login
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // Kalau user udah login
        return const UserHomeScreen();
      },
    );
  }
}
