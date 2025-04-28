import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 30,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Column(
        children: [
          _buildOptionTile(Icons.settings, "Pengaturan Akun"),
          const Divider(color: Colors.grey, thickness: 0.5, height: 0),
          _buildOptionTile(Icons.headphones, "Bantuan"),
          const Divider(color: Colors.grey, thickness: 0.5, height: 0),
          _buildOptionTile(
            Icons.logout,
            "Keluar",
            color: Colors.red,
            iconColor: Colors.red,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), // ganti dengan halaman login kamu
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    IconData icon,
    String title, {
    Color color = Colors.black,
    Color iconColor = Colors.grey,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Icon(icon, color: iconColor, size: 30),
      title: Text(title, style: TextStyle(color: color, fontSize: 15)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
