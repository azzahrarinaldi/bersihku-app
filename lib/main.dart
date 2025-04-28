import 'package:bersihku/firebase_options.dart';
import 'package:bersihku/provider/auth_provider.dart';
import 'package:bersihku/ui/admin-front/home-admin/admin_home_screen.dart';
import 'package:bersihku/ui/auth_wrapper.dart';
import 'package:bersihku/ui/user-front/history/detail-history/detail_screen.dart';
import 'package:bersihku/ui/user-front/home-user/user_home_screen.dart';
import 'package:bersihku/ui/splash_screen.dart';
import 'package:bersihku/ui/on-boarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi Google Sign-In
  await GoogleSignIn().isSignedIn(); // Ini untuk memastikan plugin Google Sign-In terdeteksi

  // Jalankan app dengan provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: '/', 
      routes: {
        '/': (context) => const SplashScreen(),
        '/auth-wrapper': (context) => const AuthWrapper(),
        '/on-boarding' : (context) => const OnboardingScreen(),
        '/home-user' : (context) => const UserHomeScreen(),
        '/detail-history' : (context) => const DetailScreenHistory(),
        '/home-admin' : (context) => const AdminHomeScreen(),
      },
    );
  }
}