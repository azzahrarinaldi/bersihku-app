import 'package:flutter/material.dart';

class PasswordHint extends StatefulWidget {
  final TextEditingController passwordController;
  final bool Function(String) isPasswordStrong;

  const PasswordHint({
    super.key,
    required this.passwordController,
    required this.isPasswordStrong,
  });

  @override
  State<PasswordHint> createState() => _PasswordHintState();
}

class _PasswordHintState extends State<PasswordHint> {
  late String password;

  @override
  void initState() {
    super.initState();
    password = widget.passwordController.text;

    widget.passwordController.addListener(() {
      setState(() {
        password = widget.passwordController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isStrong = widget.isPasswordStrong(password);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: isStrong ? Color(0xFF4AB1DA).withOpacity(0.1) : const Color(0xFFFFF6D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              isStrong ? "Kata Sandi Kuat 💪" : "Coba ketikkan Kata Sandi",
              style: TextStyle(
                color: isStrong ? Color(0xFF4AB1DA) : const Color(0xFFDAA520),
                fontSize: 13,
              ),
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
                  // ignore: deprecated_member_use
                  color: isStrong ? Color(0xFF4AB1DA) : Colors.amber.withOpacity(0.3),
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
