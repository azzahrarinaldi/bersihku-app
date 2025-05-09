import 'package:bersihku/controllers/laporan_masuk_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bersihku/const.dart';
import 'package:bersihku/ui/admin-front/home-admin/laporan-masuk/components/dropdown_wilayah.dart';
import 'package:bersihku/ui/admin-front/home-admin/laporan-masuk/components/pengangkutan_card.dart';
import 'package:bersihku/ui/admin-front/home-admin/laporan-masuk/components/rekapan_card.dart';

class LaporanMasukScreen extends StatelessWidget {
  const LaporanMasukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaporanMasukController());
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

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
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownWilayah(
                          selectedWilayah: controller.selectedWilayah.value,
                          wilayahList: controller.wilayahList,
                          onChanged: controller.updateWilayah,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.filteredList.length,
                            itemBuilder: (context, index) {
                              final data = controller.filteredList[index];
                              return Column(
                                children: [
                                  PengangkutanCard(
                                    data: controller.filteredList[index],
                                    imageAsset:
                                        "assets/images/profile-laporan-img.png",
                                    onTapDetail: () {
                                      Get.toNamed('/detail-laporan-masuk');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
