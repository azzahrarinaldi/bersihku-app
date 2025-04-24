import 'package:bersihku/ui/auth/sign-up/signup_screen.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode passwordFocusNode;
  final bool isPasswordVisible;
  final VoidCallback setPasswordVisible;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.passwordFocusNode,
    required this.isPasswordVisible,
    required this.setPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        focusNode: passwordFocusNode,
        obscureText: !isPasswordVisible,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: "Masukkan Kata Sandi",
          hintStyle: const TextStyle(fontSize: 14, color: hintTextColor),
          filled: true,
          fillColor: fieldBg,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          suffixIcon: IconButton(
            icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: setPasswordVisible,
          ),
          helperText: passwordFocusNode.hasFocus ? "Minimal 8 karakter" : null,
          helperStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
