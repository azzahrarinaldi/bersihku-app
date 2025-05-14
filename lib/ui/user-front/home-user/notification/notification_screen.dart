import 'package:bersihku/const.dart';
import 'package:bersihku/ui/user-front/home-user/notification/components/notif_card.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Stack(
        children: [
          // Background atas (gambar + orange)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pattern_oren.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Konten utama
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white,)
                        ),
                      Text(
                        "Detail Notifikasi",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
            
                // Info atas (TETAP di background putih)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications_active,
                            color: Colors.orange),
                            SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notifikasi Baru",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Ada 1 pengangkutan terdekat hari ini.",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            
                const SizedBox(height: 30),
            
                // Expanded scroll area
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18),
                      children: [
                        NotificationCard(
                          profileImage: "assets/images/profile.png",
                          name: "Hadi Sucipto",
                          roleAndPlate: "Sopir / (B889N)",
                          location: "Kemang Village Apartment",
                          date: "Rabu, 26 Februari 2025",
                          address:
                              "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
                          notes:
                              "Ini adalah contoh catatan yang dikasih Admin kepada Supir...",
                          isNew: true,
                        ),
                        NotificationCard(
                          profileImage: "assets/images/profile.png",
                          name: "Hadi Sucipto",
                          roleAndPlate: "Sopir / (B889N)",
                          location: "Kemang Village Apartment",
                          date: "Rabu, 26 Februari 2025",
                          address:
                              "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
                          notes:
                              "Ini adalah contoh catatan yang dikasih Admin kepada Supir...",
                        ),
                        NotificationCard(
                          profileImage: "assets/images/profile.png",
                          name: "Hadi Sucipto",
                          roleAndPlate: "Sopir / (B889N)",
                          location: "Kemang Village Apartment",
                          date: "Rabu, 26 Februari 2025",
                          address:
                              "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
                          notes:
                              "Ini adalah contoh catatan yang dikasih Admin kepada Supir...",
                        ),
                      ],
                    ),
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
