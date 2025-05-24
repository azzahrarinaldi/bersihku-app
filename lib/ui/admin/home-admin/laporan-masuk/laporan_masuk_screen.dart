import 'package:bersihku/controller/laporan_masuk_controller.dart';
import 'package:bersihku/ui/admin/home-admin/laporan-masuk/components/rekapan_card.dart';
import 'package:bersihku/ui/admin/home-admin/laporan-masuk/components/pengangkutan_card.dart';
import 'package:bersihku/ui/admin/home-admin/laporan-masuk/components/dropdown_wilayah.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bersihku/const.dart';

class LaporanMasukScreen extends StatelessWidget {
  const LaporanMasukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(LaporanMasukController());
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: 15,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: Get.back,
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  const Text(
                    'Cek Laporan Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // rekapan
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: RekapanCard(),
            ),
            const SizedBox(height: 24),

            // wilayah + list
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownWilayah(
                        selectedWilayah: ctrl.selectedWilayah.value,
                        wilayahList: ctrl.wilayahList,
                        onChanged: ctrl.updateWilayah,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: ctrl.filteredList.length,
                          itemBuilder: (c, i) {
                            final item = ctrl.filteredList[i];
                            return Column(
                              children: [
                                PengangkutanCard(
                                  data: item,
                                  onTapDetail: () {
                                    Get.toNamed(
                                      '/detail-laporan-masuk',
                                      arguments: item.id,
                                    );
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
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