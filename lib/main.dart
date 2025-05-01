import 'package:bersihku/ui/admin-front/home-admin/admin_home_screen.dart';
import 'package:bersihku/ui/admin-front/home-admin/data-supir/data_supir_screen.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-data-supir/detail_data_supir_screen.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-laporan/detail_laporan_screen.dart';
import 'package:bersihku/ui/admin-front/home-admin/laporan-masuk/laporan_masuk_screen.dart';
import 'package:bersihku/ui/user-front/history/detail-history/detail_screen.dart';
import 'package:bersihku/ui/user-front/home-user/home-screen-user/user_home_screen.dart';
import 'package:bersihku/ui/splash_screen.dart';
import 'package:bersihku/ui/on-boarding/onboarding_screen.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/input_form_screen.dart';
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
        '/on-boarding' : (context) => const OnboardingScreen(),
        '/home-user' : (context) => const UserHomeScreen(),
        '/detail-history' : (context) => const DetailScreenHistory(),
        '/home-admin' : (context) => const AdminHomeScreen(),
        '/input-form' : (context) => const InputFormScreen(),
        '/detail-data-supir' : (context) => const DetailDataSupirScreen(),
        '/data-supir' : (context) => const DataSupirScreen(),
        '/laporan-masuk' : (context) => const LaporanMasukScreen(),
        '/detail-laporan-masuk' : (context) => const DetailLaporanMasukScreen(),
      },
    );
  }
}