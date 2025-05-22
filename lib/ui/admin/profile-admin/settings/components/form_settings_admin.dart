import 'package:bersihku/const.dart';
import 'package:bersihku/controller/user_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormSettingsAdminScreen extends StatefulWidget {
  const FormSettingsAdminScreen({super.key});

  @override
  State<FormSettingsAdminScreen> createState() => _FormSettingsAdminScreenState();
}

class _FormSettingsAdminScreenState extends State<FormSettingsAdminScreen> {
  final controller = Get.find<UserSettingController>();

  @override
  void initState() {
    super.initState();
    controller.loadUserProfile(); // Load data awal
  }

  InputDecoration buildInputDecoration(IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      prefixIcon: Icon(icon, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nama", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller.nameController,
            decoration: buildInputDecoration(Icons.person),
          ),
          const SizedBox(height: 20),
          const Text("No. Telepon", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            decoration: buildInputDecoration(Icons.phone),
          ),
          const SizedBox(height: 20),
          const Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: buildInputDecoration(Icons.email_rounded),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Kata Sandi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  // Bisa navigasi ke screen ganti password kalau mau
                },
                child: const Text(
                  "Ganti Kata Sandi",
                  style: TextStyle(fontSize: 14, color: textPrimary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(() => TextField(
            obscureText: controller.obscurePassword.value,
            controller: controller.passwordController,
            decoration: buildInputDecoration(Icons.lock).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  controller.obscurePassword.value ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  controller.obscurePassword.value = !controller.obscurePassword.value;
                },
              ),
            ),
          )),
          const SizedBox(height: 80),
          SizedBox(
            width: double.infinity,
            child: Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: controller.isLoading.value ? Colors.grey : thirdColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              ),
              onPressed: controller.isLoading.value ? null : controller.saveUserProfile,
              child: controller.isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16)),
            )),
          ),
        ],
      ),
    );
  }
}