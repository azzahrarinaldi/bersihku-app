import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final int currentPage;
  final VoidCallback onNext, onPrev;

  const NavigationButton({
    super.key,
    required this.currentPage,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentPage > 0
            ? FloatingActionButton(
              elevation: 0,
                onPressed: onPrev,
                backgroundColor: Color(0xFF0CA5E2),
                child: Icon(
                  Icons.arrow_back, 
                  color: Colors.white
                ),
              )
            : SizedBox(width: 56),
        FloatingActionButton(
          elevation: 0,
          onPressed: onNext,
          backgroundColor: Color(0xFF0CA5E2),
          child: Icon(
            Icons.arrow_forward, 
            color: Colors.white
          ),
        ),
      ],
    );
  }
}