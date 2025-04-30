import 'package:bersihku/const.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-data-supir/components/data_supir_header.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-data-supir/components/data_supir_profile.dart';
import 'package:flutter/material.dart';
import 'components/laporan_item.dart';

class DetailDataSupirScreen extends StatelessWidget {
  const DetailDataSupirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blue-pettern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const DataSupirHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const DataSupirProfile(),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, 
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Laporan Terakhir",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const LaporanItem(
                          lokasi: 'Mall Artha Gading',
                          alamat:
                              'Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading',
                          hari: 'Rabu',
                          tanggal: '26 Februari 2025',
                          jam: '21.00–06.00',
                          berat: '679 Kg',
                        ),
                        const SizedBox(height: 20),
                        const LaporanItem(
                          lokasi: 'Margo City',
                          alamat:
                              'Jl. Margonda Raya No.358, Kemiri Muka, Kecamatan Beji',
                          hari: 'Selasa',
                          tanggal: '25 Februari 2025',
                          jam: '21.00–06.00',
                          berat: '976 Kg',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}