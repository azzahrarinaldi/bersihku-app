import 'package:bersihku/controller/profile_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileOptionsUser extends StatelessWidget {
  const ProfileOptionsUser({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileUserController>();

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
          ),
        ],
      ),
      child: Column(
        children: [
          _buildOptionTile(
            icon: Icons.settings,
            title: "Pengaturan Akun",
            onTap: () => Get.toNamed('/user-settings'),
          ),
          const Divider(color: Colors.grey, thickness: 0.5, height: 0),

          _buildOptionTile(
            icon: Icons.help_outline,
            title: "Bantuan",
            onTap: () => Get.toNamed('/guide'),
          ),
          const Divider(color: Colors.grey, thickness: 0.5, height: 0),

          _buildOptionTile(
            icon: Icons.logout,
            title: "Keluar",
            color: Colors.red,
            onTap: () async {
              await controller.logoutAndRedirect();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback? onTap,
    Color color = Colors.black,
    Color iconColor = Colors.grey,
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