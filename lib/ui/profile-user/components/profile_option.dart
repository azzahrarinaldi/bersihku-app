import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
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
        ]
      ),
      child: Column(
        children: [
          _buildOptionTile(Icons.settings, "Pengaturan Akun"),
          const Divider(color: Colors.grey, thickness: 0.5, height: 0),
          _buildOptionTile(Icons.headphones, "Bantuan"),
          const Divider(color: Colors.grey, thickness: 0.5, height: 0),
          _buildOptionTile(Icons.logout, Color: Colors.red, "Keluar", color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, {Color color = Colors.black, Color = Colors.grey}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Icon(icon, color: Color, size: 30),
      title: Text(title, style: TextStyle(color: color, fontSize: 15)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
