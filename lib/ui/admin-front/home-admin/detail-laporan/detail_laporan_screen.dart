import 'package:bersihku/controllers/laporan_masuk_controller.dart';
import 'package:bersihku/models/card_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bersihku/const.dart';
import 'package:bersihku/controllers/detail_laporan_controller.dart';
import 'components/profile_info.dart';
import 'components/rincian_pengangkutan.dart';
import 'components/foto_sampah.dart';

class DetailLaporanMasukScreen extends StatelessWidget {
  final String id;

  DetailLaporanMasukScreen({Key? key}) : id = Get.arguments.toString(), super(key: key);

  @override
  Widget build(BuildContext context) {
    final laporanMasukController = Get.find<LaporanMasukController>();
    final detailLaporanController = Get.find<DetailLaporanController>();

    // Ambil data utama dari card
    final CardDataModel data = laporanMasukController.filteredList
    .firstWhere((item) => item.id == id);

    // Filter data detail berdasarkan nama dan tempat
    final detail = detailLaporanController.laporanList
    .firstWhereOrNull((laporan) => laporan.id == id);

    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: 15),
              decoration: BoxDecoration(color: primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        "Laporan Detail Pengangkutan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4F1FC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Laporan ${data.name}:",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimary),
                        ),
                        Text(
                          "${detailLaporanController.getJumlahLaporanByName(data.name)} Laporan",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 30,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfo(
                        name: data.name,
                        vehicle: data.vehicle,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RincianPengangkutan(
                              place: data.place,
                              address: data.address,
                              time: data.time,
                              weightTotal: detail?.weightTotal ?? '0.0',
                            ),
                            const SizedBox(height: 30),
                            FotoSampah(
                              title:
                                  "Foto Sampah Sebelum Diangkat",
                              imageUrl: detail?.urlFotoSebelum ?? '',
                            ),
                            const SizedBox(height: 30),
                            FotoSampah(
                              title:
                                  "Foto Sampah Sesudah Diangkat",
                              imageUrl: detail?.urlFotoSesudah ?? '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}