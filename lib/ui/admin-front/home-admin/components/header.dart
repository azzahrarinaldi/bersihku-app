import 'package:bersihku/const.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final double screenWidth;

  const HeaderSection({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Selamat Datang,",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    "Nuara 👋🏻",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Image.asset("assets/icons/notification.png",
                  width: 40, height: 40),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
            ),
            child: Text(
              "Riwayat Pengangkutan Terbaru",
              style:
                  TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}