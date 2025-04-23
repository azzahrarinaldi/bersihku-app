import 'package:bersihku/ui/history/detail-history/detail_screen.dart';
import 'package:bersihku/ui/home/home_screen.dart';
import 'package:bersihku/ui/splash_screen.dart';
import 'package:bersihku/ui/on-boarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        fontFamily: 'PlusJakartaSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF757575)),
          bodySmall: TextStyle(color: Color(0xFF757575)),
        ),
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => const SplashScreen(),
        '/on-boarding' : (context) => const OnboardingScreen(),
        '/home' : (context) => const HomeScreen(),
        '/detail-history' : (context) => const DetailScreenHistory(),
      },
    );
  }
}