import 'package:bersihku/const.dart';
import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:bersihku/ui/auth/sign-up/components/custom_password_field.dart';
import 'package:bersihku/ui/auth/sign-up/components/custom_text_field.dart';
import 'package:bersihku/ui/auth/sign-up/components/password_hint.dart';
import 'package:bersihku/ui/auth/sign-up/components/social_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_onFormChange);
    passwordController.addListener(_onFormChange);
    nameController.addListener(_onFormChange);
    phoneController.addListener(_onFormChange);
  }

  @override
  void dispose() {
    emailController.removeListener(_onFormChange);
    passwordController.removeListener(_onFormChange);
    nameController.removeListener(_onFormChange);
    phoneController.removeListener(_onFormChange);

    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _onFormChange() => setState(() {});

  bool isPasswordStrong(String password) => password.length >= 8;

  bool get isFormValid {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          hint: 'Masukkan Email',
                          validator: (value) {
                            if (value?.isEmpty ?? true) return 'Email tidak boleh kosong';
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) return 'Email tidak valid';
                            return null;
                          },
                        ),
                        CustomPasswordField(
                          controller: passwordController,
                          isPasswordVisible: isPasswordVisible,
                          setPasswordVisible: () => setState(() => isPasswordVisible = !isPasswordVisible),
                          validator: (value) {
                            if (value?.isEmpty ?? true) return 'Password tidak boleh kosong';
                            if (!isPasswordStrong(value!)) return 'Password minimal 8 karakter';
                            return null;
                          },
                          passwordFocusNode: passwordFocusNode,
                        ),
                        const SizedBox(height: 10),
                        PasswordHint(
                          passwordController: passwordController,
                          isPasswordStrong: isPasswordStrong,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: nameController,
                          hint: 'Masukkan Nama Lengkap',
                          validator: (value) => (value?.isEmpty ?? true) ? 'Nama tidak boleh kosong' : null,
                        ),
                        CustomTextField(
                          controller: phoneController,
                          hint: 'Masukkan Nomor HP',
                          validator: (value) => (value?.isEmpty ?? true) ? 'Nomor HP tidak boleh kosong' : null,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: isFormValid ? _registerUser : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFormValid ? primaryColor : Colors.grey,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
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
                      onTap: _signInWithGoogle, 
                      text: 'Google',
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
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

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final user = cred.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': emailController.text.trim(),
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'role': 'user',
          'created_at': FieldValue.serverTimestamp(),
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi gagal: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final snapshot = await userDoc.get();

        if (!snapshot.exists) {
          await userDoc.set({
            'email': user.email,
            'name': user.displayName,
            'phone': user.phoneNumber ?? '',
            'role': 'user',
            'created_at': FieldValue.serverTimestamp(),
          });
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil daftar/login dengan Google!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal login Google: $e')),
      );
    }
  }
}
