import 'package:bersihku/controllers/laporan_masuk_controller.dart';
import 'package:bersihku/controllers/detail_laporan_controller.dart';
import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-laporan/components/foto_sampah.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-laporan/components/profile_info.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-laporan/components/rincian_pengangkutan.dart';
import 'package:bersihku/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailLaporanMasukScreen extends StatelessWidget {
  const DetailLaporanMasukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Get.arguments.toString();
    final laporanMasukController = Get.find<LaporanMasukController>();
    final detailLaporanController = Get.put(DetailLaporanController());

    // Data utama
    final DetailLaporanModel data = laporanMasukController.laporanList
        .firstWhere((item) => item.id == id);

    // format tanggal & waktu
    final formattedDate = DateFormat('EEEE, d MMMM yyyy', 'id').format(data.createdAt);
    final formattedTime = DateFormat('HH:mm').format(data.createdAt);


    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header & Rekapan singkat
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: 15),
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Laporan Detail Pengangkutan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimary),
                        ),
                        Obx(() => Text(
                          "${detailLaporanController.getJumlahLaporanByUserId(data.name)} Laporan",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textPrimary
                          ),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Konten Detail
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 30,
                      offset: const Offset(0, -2),
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
                        profilePicture: data.profilePicture,
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
                              date: formattedDate,
                              time: formattedTime,
                              weightTotal: "${data.formattedWeight} Kg"
                            ),
                            const SizedBox(height: 20),
                            FotoSampah(
                              title: "Foto Sampah Sebelum Diangkat",
                              imageUrls: data.imagesBasah,
                            ),
                            const SizedBox(height: 20),
                            FotoSampah(
                              title: "Foto Sampah Sesudah Diangkat",
                              imageUrls: data.imagesKering,
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