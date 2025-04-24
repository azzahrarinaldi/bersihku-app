import 'package:bersihku/ui/auth/login/components/social_button.dart';
import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:bersihku/ui/auth/sign-up/components/custom_password_field.dart';
import 'package:bersihku/ui/auth/sign-up/components/custom_text_field.dart';
import 'package:bersihku/ui/auth/sign-up/components/password_hint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const Color textColor = Color(0xFF333333);
const Color primaryColor = Color(0xFFA1A1A1);
const Color hintTextColor = Color(0xFF9E9E9E);
const Color fieldBg = Color(0xFFF5F7FA);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  bool isPasswordVisible = false;
  bool isPasswordFieldFocused = false;

  @override
  void initState() {
    super.initState();
    passwordFocusNode.addListener(() {
      setState(() {
        isPasswordFieldFocused = passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  bool isPasswordStrong(String password) => password.length >= 8;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String password = passwordController.text;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.4,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/images/signup.png', fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Daftar Akun", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: textColor)),
                  const SizedBox(height: 24),
                  CustomTextField(controller: emailController, hint: "Masukkan Email"),
                  CustomPasswordField(controller: passwordController, passwordFocusNode: passwordFocusNode, isPasswordVisible: isPasswordVisible, setPasswordVisible: () => setState(() => isPasswordVisible = !isPasswordVisible)),
                  const SizedBox(height: 10),
                  PasswordHint(password: password, isPasswordStrong: isPasswordStrong),
                  const SizedBox(height: 10),
                  CustomTextField(controller: nameController, hint: "Masukkan Nama Lengkap"),
                  CustomTextField(controller: phoneController, hint: "Masukkan Nomor HP"),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty || phoneController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Semua field harus diisi')));
                        return;
                      }

                      try {
                        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                        final user = userCredential.user;
                        if (user != null) {
                          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                            'email': emailController.text.trim(),
                            'name': nameController.text.trim(),
                            'phone': phoneController.text.trim(),
                            'role': 'user',
                            'created_at': FieldValue.serverTimestamp(),
                          });

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          }
                        }
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registrasi gagal: ${e.message}')));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Daftar", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  const Center(child: Text("Atau daftar dengan:", style: TextStyle(fontSize: 14))),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(assetPath: 'assets/icons/google-icon.png'),
                      const SizedBox(width: 16),
                      SocialButton(assetPath: 'assets/icons/facebook-icon.png'),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Wrap(
                      children: const [
                        Text("Sudah punya akun? ", style: TextStyle(fontSize: 14)),
                        Text("Masuk", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
                      ],
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
