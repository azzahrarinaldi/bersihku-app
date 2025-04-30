import 'package:bersihku/const.dart';
import 'package:bersihku/ui/admin-front/home-admin/home-screen-user/components/buttom_navbar.dart';
import 'package:bersihku/ui/admin-front/home-admin/home-screen-user/components/header.dart';
import 'package:bersihku/ui/admin-front/home-admin/home-screen-user/components/riwayat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/card_menu.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;
  bool _showManagementContainer = true; // <<< Tambahan buat hide/show

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse) {
        // Scroll ke bawah
        if (_showManagementContainer) {
          setState(() => _showManagementContainer = false);
        }
      } else if (notification.direction == ScrollDirection.forward) {
        // Scroll ke atas
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
      backgroundColor: const Color(0xFF4EBAE5),
      body: Stack(
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
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      children: const [
                        RiwayatCard(),
                        RiwayatCard(),
                        RiwayatCard(),
                        SizedBox(height: 100), // kasih space bawah biar nyaman scroll
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Ini container putihnya, pakai AnimatedPositioned biar smooth
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: _showManagementContainer ? 0 : -300, // kalau hide, turun ke bawah
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
                        ),
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
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: !_showManagementContainer
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