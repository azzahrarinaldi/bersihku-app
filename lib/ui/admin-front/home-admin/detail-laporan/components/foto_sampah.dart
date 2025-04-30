import 'package:flutter/material.dart';

class FotoSampah extends StatelessWidget {
  final String title;

  const FotoSampah({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 15),
        Image.asset("assets/images/sampah-kering-img.png", width: 222),
        const SizedBox(height: 15),
        Image.asset("assets/images/sampah-kering-img.png", width: 222),
      ],
    );
  }
}