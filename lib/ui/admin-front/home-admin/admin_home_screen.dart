import 'package:bersihku/ui/admin-front/home-admin/components/buttom_navbar.dart';
import 'package:bersihku/ui/admin-front/home-admin/components/header.dart';
import 'package:bersihku/ui/admin-front/home-admin/components/riwayat_card.dart';
import 'package:flutter/material.dart';
import 'components/card_menu.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    children: const [
                      RiwayatCard(),
                      RiwayatCard(),
                      RiwayatCard(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                // BAGIAN BAWAH NON-SCROLLABLE (CARD MENU)
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
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
                        icon:
                            Image.asset("assets/images/laporan-masuk-img.png"),
                      ),
                      CardMenu(
                        title: "Info Data Supir",
                        subtitle: "Lihat data lengkap supir di sini!",
                        buttonText: "Kelola Supir",
                        icon: Image.asset("assets/images/data-supir-img.png"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}