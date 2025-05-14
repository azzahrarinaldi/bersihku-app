import 'package:bersihku/ui/admin-front/home-admin/home-screen-admin/admin_home_screen.dart';
import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:bersihku/ui/user-front/home-user/home-screen-user/user_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          String userId = FirebaseAuth.instance.currentUser!.uid;

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (userSnapshot.hasData && userSnapshot.data != null) {
                var userData = userSnapshot.data!.data() as Map<String, dynamic>;
                String role = userData['role'];

                // Arahkan ke halaman yang sesuai berdasarkan role
                if (role == 'admin') {
                  return AdminHomeScreen();
                } else {
                  return UserHomeScreen();
                }
              } else {
                return Center(child: Text('Data user tidak ditemukan.'));
              }
            },
          );
        } else {
          // Jika tidak ada user yang login, arahkan ke Onboarding Screen atau Login
          return LoginScreen(); // Ganti ke login screen jika perlu
        }
      },
    );
  }
}
