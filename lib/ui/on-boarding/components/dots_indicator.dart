import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int currentPage, totalPage;

  const DotsIndicator({
    super.key,
    required this.currentPage,
    required this.totalPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPage, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 28 : 12,
          height: 12,
          decoration: BoxDecoration(
            color: currentPage == index ? Color(0xFF0CA5E2) : Colors.grey[400],
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}
