import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String vehicle;
  final String profilePicture;

  const ProfileInfo({
    super.key,
    required this.name,
    required this.vehicle,
    required this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

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
                image: DecorationImage(
                  image: profilePicture.isNotEmpty
                      ? NetworkImage(profilePicture)
                      : const AssetImage('assets/images/profile-laporan-img.png')
                          as ImageProvider,
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
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
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
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCFAA),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                vehicle,
                style: const TextStyle(
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
