import 'package:bersihku/const.dart';
import 'package:bersihku/controller/riwayat_card_controller.dart';
import 'package:bersihku/controller/user_controller.dart';
import 'package:bersihku/ui/admin/home-admin/home-screen-admin/components/buttom_navbar.dart';
import 'package:bersihku/ui/admin/home-admin/home-screen-admin/components/header.dart';
import 'package:bersihku/ui/admin/home-admin/home-screen-admin/components/riwayat_card.dart';
import 'package:bersihku/ui/admin/history-admin/admin_history_screen.dart';
import 'package:bersihku/ui/admin/profile-admin/profile-admin-screen/profile_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'components/card_menu.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final riwayatController = Get.put(RiwayatController());
  final userController = Get.put(UserController()); // Pastikan diinisialisasi di sini

  int _selectedIndex = 0;
  bool _showManagementContainer = true;

  final List<Widget> _widgetOptions = [
    AdminHomeScreen(),
    AdminHistoryScreen(),
    ProfileScreenAdmin(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse) {
        if (_showManagementContainer) {
          setState(() => _showManagementContainer = false);
        }
      } else if (notification.direction == ScrollDirection.forward) {
        if (!_showManagementContainer) {
          setState(() => _showManagementContainer = true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: _selectedIndex == 0
          ? Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/blue-pettern.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderSection(screenWidth: screenWidth),
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            _onScroll(notification);
                            return true;
                          },
                          child: Obx(() {
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              itemCount:
                                  riwayatController.riwayatList.length,
                              itemBuilder: (context, index) {
                                if (index < riwayatController.riwayatList.length) {
                                  final item = riwayatController.riwayatList[index];
                                  return RiwayatCard(data: item);
                                } else {
                                  return const SizedBox(height: 100);
                                }
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: _showManagementContainer ? 0 : -300,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.calendar_today, color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              "Manajemen Anda",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        CardMenu(
                          title: "Cek Laporan Masuk",
                          subtitle: "Lihat laporan yang perlu dicek sekarang!",
                          buttonText: "Cek Laporan Masuk",
                          icon: Image.asset(
                            "assets/images/laporan-masuk-img.png",
                            width: 40,
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/laporan-masuk');
                          },
                        ),
                        CardMenu(
                          title: "Info Data Supir",
                          subtitle: "Lihat data lengkap supir di sini!",
                          buttonText: "Kelola Supir",
                          icon: Image.asset(
                            "assets/images/data-supir-img.png",
                            width: 40,
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/data-supir');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : _widgetOptions[_selectedIndex],
      bottomNavigationBar: AdminBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0 && !_showManagementContainer
          ? FloatingActionButton(
              backgroundColor: primaryColor,
              elevation: 0,
              mini: true,
              onPressed: () {
                setState(() {
                  _showManagementContainer = true;
                });
              },
              child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
            )
          : null,
    );
  }
}