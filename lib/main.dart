import 'package:bersihku/firebase_options.dart';
import 'package:bersihku/ui/auth_wrapper.dart';
import 'package:bersihku/ui/user-front/home-user/guide/guide_screen.dart';
import 'package:bersihku/ui/user-front/home-user/home-screen-user/user_home_screen.dart';
import 'package:bersihku/ui/splash_screen.dart';
import 'package:bersihku/ui/on-boarding/onboarding_screen.dart';
import 'package:bersihku/ui/user-front/profile-user/settings/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/input_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi Google Sign-In
  await GoogleSignIn().isSignedIn(); // Ini untuk memastikan plugin Google Sign-In terdeteksi

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bersihku',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Plus Jakarta Sans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF757575)),
          bodySmall: TextStyle(color: Color(0xFF757575)),
        ),
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/' : '/auth-wrapper',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/auth-wrapper', page: () => const AuthWrapper()),
        GetPage(name: '/on-boarding', page: () => const OnboardingScreen()),
        GetPage(name: '/home-user', page: () => const UserHomeScreen()),
        GetPage(name: '/input-form', page: () => const InputFormScreen()),
        GetPage(name: '/user-settings', page: () => UserSettingsScreen()),
        GetPage(name: '/guide', page: () => HelpGuideScreen()),
      ],
    );
  }
}