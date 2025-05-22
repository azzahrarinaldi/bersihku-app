import 'package:bersihku/controller/user_home_controller.dart';
import 'package:bersihku/ui/user-front/history/history-screen/history_screen.dart';
import 'package:bersihku/ui/user-front/home-user/home-screen-user/components/bottom_navbar.dart';
import 'package:bersihku/ui/user-front/home-user/home-screen-user/components/contraints.dart';
import 'package:bersihku/ui/user-front/home-user/home-screen-user/components/guide.dart';
import 'package:bersihku/ui/user-front/home-user/home-screen-user/components/report.dart';
import 'package:bersihku/ui/user-front/profile-user/profile-user-screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

final UserHomeController userHomeController = Get.put(UserHomeController());

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    //dasar untuk bernavigasi via bottom nav bar
    const UserHomeScreen(),
    const HistoryScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      /*menyatakan bahwa initial actionnya adalah untuk menampilkan objek yg berada pada index 0*/
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF4EBAE5),
      body: _selectedIndex == 0
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/blue-pettern.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () {
                          final userName = userHomeController.user.value!.name??
                              "User"; // Ambil user ID dari Firebase Authentication

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hai, $userName 👋🏻", // Menggunakan userName yang diambil dari Firebase
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Siap menjemput sampah hari ini?",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: screenWidth * 0.06),
                      const Guide(),
                      SizedBox(height: screenWidth * 0.05),
                      const Text(
                        "Drop In",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Report(),
                      const SizedBox(height: 24),
                      const Constraints(),
                    ],
                  ),
                ),
              ),
            )
          : _widgetOptions[
              _selectedIndex], //titik dua itu adalah repersentasi dari ternari operator di flutter, tampilkan widget berdasarkan index
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
