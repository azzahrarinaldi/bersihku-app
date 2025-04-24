import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final double screenWidth;

  const HeaderSection({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
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
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          Image.asset("assets/icons/notification.png", width: 40, height: 40),
        ],
      ),
    );
  }
}