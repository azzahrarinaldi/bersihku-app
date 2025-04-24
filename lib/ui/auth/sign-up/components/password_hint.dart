import 'package:flutter/material.dart';

class PasswordHint extends StatelessWidget {
  final String password;
  final bool Function(String) isPasswordStrong;

  const PasswordHint({super.key, required this.password, required this.isPasswordStrong});

  @override
  Widget build(BuildContext context) {
    final bool isStrong = isPasswordStrong(password);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isStrong ? Colors.blue.withOpacity(0.1) : const Color(0xFFFFF6D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              isStrong ? "Kata Sandi Kuat 💪" : "Coba ketikkan Kata Sandi",
              style: TextStyle(color: isStrong ? Colors.blue : const Color(0xFFDAA520), fontSize: 13),
            ),
          ),
          Row(
            children: List.generate(
              3,
              (index) => Container(
                width: 16,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isStrong ? Colors.blue : Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
