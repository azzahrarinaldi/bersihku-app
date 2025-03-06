import 'package:flutter/material.dart';
import 'components/onboarding_content.dart';
import 'components/navigation_button.dart';
import 'components/dots_indicator.dart';
import 'components/auth_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding-1.png",
      "title": "Pantau dan Atur \nJadwal dengan Mudah",
      "description":
          "Cek laporan masuk, atur jadwal pengangkutan, dan kelola supir dalam satu aplikasi praktis.",
    },
    {
      "image": "assets/images/onboarding-2.png",
      "title": "Optimalkan Jadwal \nLebih Efisien",
      "description":
          "Buat jadwal pengangkutan, pantau proses berjalan, dan tingkatkan produktivitas perusahaan Anda.",
    },
    {
      "image": "assets/images/onboarding-3.png",
      "title": "Mulai Sekarang \nKelola Sampah Mudah!",
      "description":
          "Bergabunglah sekarang dan nikmati kemudahan pengelolaan sampah dengan teknologi canggih Bersihku.",
    },
  ];

  void _navigatePage(bool isNext) {
    _pageController.animateToPage(
      isNext ? _currentPage + 1 : _currentPage - 1,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFC6EFFF),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => OnboardingContent(
              image: onboardingData[index]["image"]!,
              title: onboardingData[index]["title"]!,
              description: onboardingData[index]["description"]!,
              currentPage: _currentPage,
              totalPages: onboardingData.length,
            ),
          ),
          Positioned(
            bottom: size.height * 0.15,
            left: 0,
            right: 0,
            child: DotsIndicator(
                currentPage: _currentPage, totalPage: onboardingData.length),
          ),
          _currentPage == onboardingData.length - 1
              ? Align(
                  alignment: Alignment.center, 
                  child: AuthButton(),
                )
              : Positioned(
                  bottom: size.height * 0.07,
                  left: size.width * 0.1,
                  right: size.width * 0.1,
                  child: NavigationButton(
                    currentPage: _currentPage,
                    onNext: () => _navigatePage(true),
                    onPrev: () => _navigatePage(false),
                  ),
                ),
        ],
      ),
    );
  }
}