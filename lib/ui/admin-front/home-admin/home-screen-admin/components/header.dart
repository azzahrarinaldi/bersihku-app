import 'package:bersihku/const.dart';
import 'package:bersihku/controllers/user_controller.dart';
import 'package:bersihku/ui/admin-front/notification-screen/admin_detail_notifikasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderSection extends StatelessWidget {
  final double screenWidth;

  const HeaderSection({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>(); // Menggunakan Get.find()

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang,",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    "${userController.userName.value} 👋🏻", // Akses data userName
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailNotifikasiAdmin(),
                    ),
                  );
                },
                child: Image.asset(
                  "assets/icons/non-active-notification.png",
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
            ),
            child: Text(
              "Riwayat Pengangkutan Terbaru",
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}