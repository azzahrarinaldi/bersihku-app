import 'package:flutter/material.dart';
import 'package:bersihku/ui/user-front/home-user/guide/components/instruction_cards.dart';

class HelpGuideScreen extends StatelessWidget {
  const HelpGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    final List<Map<String, String>> instructionData = [
      {
        "text": "1. Buka aplikasi",
        "imagePath": "assets/images/app.png",
        "width": "70",
      },
      {
        "text": "2. Masuk ke menu utama",
        "imagePath": "assets/images/login-or-sign-in.png",
        "width": "150",
      },
      {
        "text": "3. Kalau pilih Sign Up, isi form:",
        "imagePath": "assets/images/list-guide.png",
        "width": "150",
      },
      {
        "text": "4. Kalau pilih Login, masukin:",
        "imagePath": "assets/images/list-no-hp.png",
        "width": "100",
      },
      {
        "text": "5. Kalau udah sukses, langsung masuk ke Dashboard User.",
        "imagePath": "assets/images/dashboard-user.png",
        "width": "150",
      },
      {
        "text": "6. Di bagian sini akan ada nama user dan notifikasi",
        "imagePath": "assets/images/username.png",
        "width": "150",
      },
      {
        "text": "7. Fitur Drop In, untuk membuat Laporan pengangkutan sampah",
        "imagePath": "assets/images/reposrt-card.png",
        "width": "150",
      },
      {
        "text":
            "8. Ketika button di klik maka user akan otomatis di arahkan ke WA admin",
        "imagePath": "assets/images/problem-card.png",
        "width": "150",
      },
      {
        "text": "9. Di sini terdapat history/pengangkutan terbaru",
        "imagePath": "assets/images/history-card.png",
        "width": "150",
      },
      {
        "text":
            "10. Tentunya di Dashboard ada Navigation Bar, yg berisi Home(Beranda), History, Profile",
        "imagePath": "assets/images/bottom-nav-bar-image.png",
        "width": "200",
      },
      {
        "text":
            "11. Di History berisi history pengangkutan sampah user mulai dari yg terbaru sampai beberapa bulan lalu",
        "imagePath": "assets/images/history-card.png",
        "width": "150",
      },
      {
        "text": "12. Di sini terdapat history/pengangkutan terbaru",
        "imagePath": "assets/images/history-card.png",
        "width": "150",
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/orange-pattern.png"),
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        0.07, 
                    vertical: MediaQuery.of(context).size.height *
                        0.015, 
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Panduan",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child:
                      Image.asset("assets/images/guide-image.png", width: 100),
                ),
                const SizedBox(height: 29),
                Expanded(
                  child: SingleChildScrollView(
                    child: InstructionCards(instructions: instructionData),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}