import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback setPasswordVisible;
  final FormFieldValidator<String>? validator;
  final FocusNode passwordFocusNode;
  final void Function(String)? onChanged;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.isPasswordVisible,
    required this.setPasswordVisible,
    this.validator,
    required this.passwordFocusNode,
    this.onChanged,  
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: !isPasswordVisible,
        focusNode: passwordFocusNode,
        onChanged: onChanged,  
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: setPasswordVisible,
          ),
          filled: true,
          fillColor: const Color(0xFFF5F7FA),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
