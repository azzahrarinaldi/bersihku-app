import 'package:bersihku/const.dart';
import 'package:flutter/material.dart';

class FormSettingsScreen extends StatefulWidget {
  const FormSettingsScreen({super.key});

  @override
  State<FormSettingsScreen> createState() => _FormSettingsScreenState();
}

class _FormSettingsScreenState extends State<FormSettingsScreen> {
  final TextEditingController _nameController = TextEditingController(text: "Kanaya Riany");
  final TextEditingController _phoneController = TextEditingController(text: "081234567890");
  final TextEditingController _emailController = TextEditingController(text: "kanaya@email.com");
  final TextEditingController _passwordController = TextEditingController(text: "password123");

  @override
  Widget build(BuildContext context) {
    InputDecoration buildInputDecoration(IconData icon) {
      return InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        prefixIcon: Icon(icon, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nama",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              _nameController.selection = TextSelection(baseOffset: 0, extentOffset: _nameController.text.length);
            }
          },
          child: TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.black38),
            decoration: buildInputDecoration(Icons.person),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "No. Telepon",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          style: const TextStyle(color: Colors.black38),
          keyboardType: TextInputType.phone,
          decoration: buildInputDecoration(Icons.phone),
        ),
        const SizedBox(height: 20),
        const Text(
          "Email",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.black38),
          keyboardType: TextInputType.emailAddress,
          decoration: buildInputDecoration(Icons.email),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Kata Sandi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const Text(
              "Ganti Kata Sandi",
              style: TextStyle(fontSize: 14, color: textPrimary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          style: const TextStyle(color: Colors.black38),
          obscureText: true,
          decoration: buildInputDecoration(Icons.lock),
        ),
        const SizedBox(height: 80),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            onPressed: () {
              // Submit action here
              print("Submit pressed");
            },
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
