import 'package:bersihku/bindings/detail_data_supir_binding.dart';
import 'package:bersihku/bindings/detail_laporan_binding.dart';
import 'package:bersihku/firebase_options.dart';
import 'package:bersihku/ui/admin/home-admin/data-supir/data_supir_screen.dart';
import 'package:bersihku/ui/admin/home-admin/detail-data-supir/detail_data_supir_screen.dart';
import 'package:bersihku/ui/admin/home-admin/detail-laporan/detail_laporan_screen.dart';
import 'package:bersihku/ui/admin/home-admin/home-screen-admin/admin_home_screen.dart';
import 'package:bersihku/ui/admin/home-admin/laporan-masuk/laporan_masuk_screen.dart';
import 'package:bersihku/ui/admin/profile-admin/profile-admin-screen/profile_admin_screen.dart';
import 'package:bersihku/ui/admin/profile-admin/settings/settings_admin_screen.dart';
import 'package:bersihku/ui/auth_wrapper.dart';
import 'package:bersihku/ui/user/home-user/guide/guide_screen.dart';
import 'package:bersihku/ui/user/home-user/home-screen-user/user_home_screen.dart';
import 'package:bersihku/ui/user/home-user/input-form/input_form_screen.dart';
import 'package:bersihku/ui/user/profile-user/settings/settings_screen.dart';
import 'package:bersihku/ui/splash_screen.dart';
import 'package:bersihku/ui/on-boarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi Google Sign-In
  await GoogleSignIn().isSignedIn(); // Ini untuk memastikan plugin Google Sign-In terdeteksi

  // 1) muat semua simbol tanggal/waktu untuk locale 'id'
  await initializeDateFormatting('id', null);

  // 2) set default locale intl ke 'id'
  Intl.defaultLocale = 'id';

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
        GetPage(name: '/user-settings', page: () => UserSettingsScreen()),
        GetPage(name: '/admin-settings', page: () => SettingsAdminScreen()),
        GetPage(name: '/guide', page: () => HelpGuideScreen()),
        GetPage(name: '/profile-admin', page: () => ProfileScreenAdmin()),
        GetPage(name: '/home-admin', page: () => const AdminHomeScreen()),
        GetPage(name: '/input-form', page: () => const InputFormScreen()),
        GetPage(name: '/detail-data-supir', page: () => DetailDataSupirScreen(), binding: DetailDataSupirBinding()),
        GetPage(name: '/data-supir', page: () => const DataSupirScreen()),
        GetPage(name: '/laporan-masuk', page: () => const LaporanMasukScreen()),
        GetPage(name: '/detail-laporan-masuk', page: () => DetailLaporanMasukScreen(), binding: DetailLaporanBinding()),
      ],
    );
  }
}