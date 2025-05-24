import 'package:bersihku/const.dart';
import 'package:bersihku/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ChangePasswordController());
    final screenWidth = MediaQuery.of(context).size.width;

    InputDecoration buildInputDecoration(
        IconData icon, String hint, RxBool obscure) {
      return InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: Obx(() => IconButton(
              icon: Icon(
                obscure.value ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                if (obscure == c.obscureOld) {
                  c.toggleObscureOld();
                // ignore: curly_braces_in_flow_control_structures
                } else if (obscure == c.obscureNew) c.toggleObscureNew();
                // ignore: curly_braces_in_flow_control_structures
                else c.toggleObscureConfirm();
              },
            )),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13, color: Colors.grey[500]),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Ganti Kata Sandi',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.07, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Password Lama',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Obx(() => TextField(
                  onChanged: c.setOldPassword,
                  obscureText: c.obscureOld.value,
                  decoration: buildInputDecoration(
                      Icons.lock, 'Masukkan password lama', c.obscureOld),
                )),
            const SizedBox(height: 20),
            const Text('Password Baru',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Obx(() => TextField(
                  onChanged: c.setNewPassword,
                  obscureText: c.obscureNew.value,
                  decoration: buildInputDecoration(
                      Icons.lock, 'Masukkan password baru', c.obscureNew),
                )),
            const SizedBox(height: 20),
            const Text('Konfirmasi Password Baru',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Obx(() => TextField(
                  onChanged: c.setConfirmPassword,
                  obscureText: c.obscureConfirm.value,
                  decoration: buildInputDecoration(
                      Icons.lock, 'Konfirmasi password baru', c.obscureConfirm),
                )),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    c.isLoading.value ? null : c.changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: thirdColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
                child: c.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white)
                    : const Text(
                        'Update Password',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
              ),
            )),
      ),
    );
  }
}
