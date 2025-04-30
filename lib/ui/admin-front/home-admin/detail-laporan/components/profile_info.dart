import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile-laporan-img.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Joko Priyanto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Plat :',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(width: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFFFCFAA),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'B 1829 POP',
                style: TextStyle(
                  color: textSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}