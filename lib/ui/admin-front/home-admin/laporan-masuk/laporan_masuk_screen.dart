import 'package:bersihku/const.dart';
import 'package:bersihku/ui/admin-front/home-admin/laporan-masuk/components/dropdown_wilayah.dart';
import 'package:bersihku/ui/admin-front/home-admin/laporan-masuk/components/pengangkutan_card.dart';
import 'package:bersihku/ui/admin-front/home-admin/laporan-masuk/components/rekapan_card.dart';
import 'package:flutter/material.dart';

class LaporanMasukScreen extends StatefulWidget {
  const LaporanMasukScreen({super.key});

  @override
  State<LaporanMasukScreen> createState() => _LaporanMasukScreenState();
}

class _LaporanMasukScreenState extends State<LaporanMasukScreen> {
  String selectedWilayah = "Pilih Wilayah";

  final List<String> wilayahList = [
    'Pilih Wilayah',
    'Margo City',
    'Kuningan City',
    'Mall Artha Gading'
  ];

  final List<Map<String, dynamic>> pengangkutanList = [
    {
      'name': "Joko Priyanto",
      'code': "B 1829 POP",
      'location': "Mall Artha Gading",
      'address': "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
      'day': "Rabu",
      'date': "26 Februari 2025",
      'time': "21.00–06.00",
      'weight': "1.648 Kg",
      'imageAsset': "assets/images/profile-laporan-img.png",
    },
    {
      'name': "Joko Priyanto",
      'code': "B 1829 POP",
      'location': "Kuningan City",
      'address': "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
      'day': "Rabu",
      'date': "26 Februari 2025",
      'time': "21.00–06.00",
      'weight': "1.648 Kg",
      'imageAsset': "assets/images/profile-laporan-img.png",
    },
    {
      'name': "Joko Priyanto",
      'code': "B 1829 POP",
      'location': "Margo City",
      'address': "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
      'day': "Rabu",
      'date': "26 Februari 2025",
      'time': "21.00–06.00",
      'weight': "1.648 Kg",
      'imageAsset': "assets/images/profile-laporan-img.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    // Ini filter berdasarkan selectedWilayah
    List<Map<String, dynamic>> filteredList = selectedWilayah == "Pilih Wilayah"
        ? pengangkutanList
        : pengangkutanList
            .where((item) => item['location'] == selectedWilayah)
            .toList();

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
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
                  const SizedBox(width: 8),
                  const Text(
                    'Cek Laporan Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            // Rekapan Card
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: RekapanCard(),
            ),

            const SizedBox(height: 24),

            // Wilayah dropdown dan list
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dropdown Pilih Wilayah
                      DropdownWilayah(
                        selectedWilayah: selectedWilayah,
                        wilayahList: wilayahList,
                        onChanged: (value) {
                          setState(() {
                            selectedWilayah = value;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      // List Card Pengangkutan berdasarkan filter
                      ...filteredList.map((data) {
                        return Column(
                          children: [
                            PengangkutanCard(
                              name: data['name'],
                              code: data['code'],
                              location: data['location'],
                              address: data['address'],
                              day: data['day'],
                              date: data['date'],
                              time: data['time'],
                              weight: data['weight'],
                              imageAsset: data['imageAsset'],
                              onTapDetail: () {
                                Navigator.pushNamed(context, '/detail-laporan-masuk');
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}