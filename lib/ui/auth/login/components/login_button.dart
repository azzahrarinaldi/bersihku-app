import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isFormFilled;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isFormFilled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFormFilled ? const Color(0xFF4AB1DA) : const Color(0xFFA6A6A6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: isFormFilled ? onPressed : null,
        child: const Text(
          "Masuk",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
