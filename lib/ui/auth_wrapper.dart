// ignore_for_file: library_private_types_in_public_api

import 'package:bersihku/ui/admin/home-admin/home-screen-admin/admin_home_screen.dart';
import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:bersihku/ui/user/home-user/home-screen-user/user_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuth();
  }

  Future<void> _navigateBasedOnAuth() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Belum login
      Get.offAll(() => const LoginScreen());
      return;
    }

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final role = userDoc.data()?['role']?.toString().toLowerCase() ?? 'user';

      if (role == 'admin') {
        Get.offAll(() => const AdminHomeScreen());
      } else {
        Get.offAll(() => const UserHomeScreen());
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data user: $e');
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilan splash ringan saat menunggu pengecekan role
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo-BersihKu.png", width: 50),
            SizedBox(height: 10), 
            Text("Bersihku", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}