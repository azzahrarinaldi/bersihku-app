import 'package:bersihku/ui/admin-front/home-admin/admin_home_screen.dart';
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
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasData) {
        String userId = FirebaseAuth.instance.currentUser!.uid;

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (userSnapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan: ${userSnapshot.error}'));
            }

            if (userSnapshot.hasData &&
                userSnapshot.data != null &&
                userSnapshot.data!.data() != null) {
              var userData = userSnapshot.data!.data() as Map<String, dynamic>;
              String role = userData['role'] ?? '';

              if (role == 'admin') {
                return const AdminHomeScreen();
              } else {
                return const UserHomeScreen();
              }
            } else {
              return const Center(child: Text('Data user tidak ditemukan.'));
            }
          },
        );
      } else {
        return const LoginScreen();
      }
    },
  );
}

}
