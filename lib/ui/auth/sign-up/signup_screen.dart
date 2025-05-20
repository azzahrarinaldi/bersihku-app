import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bersihku/const.dart';
import 'package:bersihku/controller/signup_controller.dart';
import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:bersihku/ui/auth/sign-up/components/custom_password_field.dart';
import 'package:bersihku/ui/auth/sign-up/components/custom_text_field.dart';
import 'package:bersihku/ui/auth/sign-up/components/password_hint.dart';
import 'package:bersihku/ui/auth/sign-up/components/social_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: size.height * 0.4,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/signup.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Daftar Akun',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: controller.emailController,
                          hint: 'Masukkan Email',
                          validator: (value) {
                            if (value?.isEmpty ?? true) return 'Email tidak boleh kosong';
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) return 'Email tidak valid';
                            return null;
                          },
                          onChanged: (val) => controller.validateForm(),
                        ),
                        Obx(() => CustomPasswordField(
                              controller: controller.passwordController,
                              isPasswordVisible: controller.isPasswordVisible.value,
                              setPasswordVisible: controller.togglePasswordVisibility,
                              validator: (value) {
                                if (value?.isEmpty ?? true) return 'Password tidak boleh kosong';
                                if (!controller.isPasswordStrong(value!)) return 'Password minimal 8 karakter';
                                return null;
                              },
                              passwordFocusNode: controller.passwordFocusNode,
                              onChanged: (val) => controller.validateForm(),
                            )),
                        const SizedBox(height: 10),
                        PasswordHint(
                          passwordController: controller.passwordController,
                          isPasswordStrong: controller.isPasswordStrong,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.nameController,
                          hint: 'Masukkan Nama Lengkap',
                          validator: (value) => (value?.isEmpty ?? true) ? 'Nama tidak boleh kosong' : null,
                          onChanged: (val) => controller.validateForm(),
                        ),
                        CustomTextField(
                          controller: controller.phoneController,
                          hint: 'Masukkan Nomor HP',
                          validator: (value) => (value?.isEmpty ?? true) ? 'Nomor HP tidak boleh kosong' : null,
                          onChanged: (val) => controller.validateForm(),
                        ),
                        const SizedBox(height: 24),
                        Obx(() => ElevatedButton(
                              onPressed: controller.isFormValid.value ? () => controller.registerUser() : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.isFormValid.value ? primaryColor : Colors.grey,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Daftar',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Atau daftar dengan:',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SocialButton(
                      assetPath: 'assets/icons/google-icon.png',
                      onTap: () => controller.signInWithGoogle(),
                      text: 'Google',
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.offAll(() => const LoginScreen()),
                      child: const Text.rich(
                        TextSpan(
                          text: 'Sudah punya akun? ',
                          style: TextStyle(fontSize: 14),
                          children: [
                            TextSpan(
                              text: 'Masuk',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4AB1DA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
