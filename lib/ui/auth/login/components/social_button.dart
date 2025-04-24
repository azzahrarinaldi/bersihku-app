import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String assetPath;

  const SocialButton({Key? key, required this.assetPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(72, 10, 72, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        assetPath,
        width: 24,
        height: 24,
      ),
    );
  }
}
