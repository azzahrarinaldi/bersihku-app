import 'package:bersihku/ui/admin-front/home-admin/home-screen-admin/admin_home_screen.dart';
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
import 'package:get/get.dart';

void main() {
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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/on-boarding', page: () => const OnboardingScreen()),
        GetPage(name: '/home-user', page: () => const UserHomeScreen()),
        GetPage(name: '/detail-history', page: () => const DetailScreenHistory()),
        GetPage(name: '/home-admin', page: () => const AdminHomeScreen()),
        GetPage(name: '/input-form', page: () => const InputFormScreen()),
        GetPage(name: '/detail-data-supir', page: () => const DetailDataSupirScreen()),
        GetPage(name: '/data-supir', page: () => const DataSupirScreen()),
        GetPage(name: '/laporan-masuk', page: () => const LaporanMasukScreen()),
        GetPage(name: '/detail-laporan-masuk', page: () => const DetailLaporanMasukScreen()),
      ],
    );
  }
}
