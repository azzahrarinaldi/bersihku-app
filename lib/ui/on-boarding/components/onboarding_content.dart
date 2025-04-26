import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String image, title, description;
  final int currentPage, totalPages;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0CA5E2),
              height: 1.2, 
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Color(0xFF0CA5E2), fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(height: 30), 
        Image.asset(image, width: double.infinity, fit: BoxFit.contain),
      ],
    );
  }
}
