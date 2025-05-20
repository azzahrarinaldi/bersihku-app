import 'package:bersihku/controller/login_controller.dart';
import 'package:bersihku/ui/auth/sign-up/signup_screen.dart';
import 'package:bersihku/ui/auth/login/components/email_input.dart';
import 'package:bersihku/ui/auth/login/components/password_input.dart';
import 'package:bersihku/ui/auth/login/components/login_button.dart';
import 'package:bersihku/ui/auth/login/components/social_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.4,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/login.png',
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
                    "Masuk Akun",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  EmailInput(controller: controller.emailController),
                  const SizedBox(height: 16),
                  PasswordInput(controller: controller.passwordController),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Lupa kata sandi?", style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                  Obx(() => LoginButton(
                        isFormFilled: controller.isFormFilled.value,
                        onPressed: controller.login,
                      )),
                  const SizedBox(height: 20),
                  const Center(child: Text("Atau masuk dengan:", style: TextStyle(fontSize: 14))),
                  const SizedBox(height: 20),
                  Center(
                    child: SocialButton(
                      assetPath: 'assets/icons/google-icon.png',
                      text: 'Google',
                      onTap: controller.signInWithGoogle,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun? "),
                      GestureDetector(
                        onTap: () => Get.to(() => const RegisterScreen()),
                        child: const Text("Buat Akun", style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
