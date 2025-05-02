import 'package:bersihku/const.dart';
import 'package:bersihku/ui/admin-front/home-admin/data-supir/components/data_supir_card.dart';
import 'package:flutter/material.dart';

class DataSupirScreen extends StatelessWidget {
  const DataSupirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/orange-pattern.png"),
            fit: BoxFit.cover,
          ),
        ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: 15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Info Data Supir',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // List Card Rekapan
                      DataSupirCard(
                      name: "Hadi Sucipto",
                      code: "B 1829 POP",
                      pengangkutanText: "Pengangkutan terakhir",
                      day: "Rabu",
                      date: "26 Februari 2025",
                      time: "21.00–06.00",
                      weight: "1.648 Kg",
                      imageAsset: "assets/images/profile-laporan-img.png", // Ini path ke asset lokal
                      onTapDetail: () {
                        Navigator.pushNamed(context, '/detail-data-supir');
                      },
                    ),
                      SizedBox(height: 16),
                      DataSupirCard(
                        name: "Joko Priyanto",
                        code: "B 1829 POP",
                        pengangkutanText: "Pengangkutan terakhir",
                        day: "Rabu",
                        date: "26 Februari 2025",
                        time: "21.00–06.00",
                        weight: "1.648 Kg",
                        imageAsset:
                            "assets/images/profile-laporan-img.png",
                        onTapDetail: () {
                          Navigator.pushNamed(context, '/detail-data-supir');
                        },
                      ),
                      SizedBox(height: 16),
                      DataSupirCard(
                        name: "Joko Priyanto",
                        code: "B 1829 POP",
                        pengangkutanText: "Pengangkutan terakhir",
                        day: "Rabu",
                        date: "26 Februari 2025",
                        time: "21.00–06.00",
                        weight: "1.648 Kg",
                        imageAsset:
                            "assets/images/profile-laporan-img.png",
                        onTapDetail: () {
                          Navigator.pushNamed(context, '/detail-data-supir');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      )
    );
  }
}