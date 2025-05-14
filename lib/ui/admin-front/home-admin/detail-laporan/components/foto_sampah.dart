import 'package:flutter/material.dart';

class FotoSampah extends StatelessWidget {
  final String title;
  final String imageUrl;

  const FotoSampah({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Image.asset(imageUrl, width: 222),
        const SizedBox(height: 15),
        Image.asset(imageUrl, width: 222),
      ],
    );
  }
}