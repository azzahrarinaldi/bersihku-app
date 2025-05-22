// ui/admin-front/home-admin/detail-data-supir/detail_data_supir_screen.dart

import 'package:bersihku/controller/detail_data_supir_controller.dart';
import 'package:bersihku/ui/admin/home-admin/detail-data-supir/components/data_supir_header.dart';
import 'package:bersihku/ui/admin/home-admin/detail-data-supir/components/data_supir_profile.dart';
import 'package:bersihku/ui/admin/home-admin/detail-data-supir/components/laporan_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bersihku/const.dart';

class DetailDataSupirScreen extends StatelessWidget {
  const DetailDataSupirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supirId = Get.arguments.toString();
    final ctrl = Get.put(DetailDataSupirController(supirId));
    final w = MediaQuery.of(context).size.width;

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

              // — Profile Supir —
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: Obx(() {
                  if (ctrl.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (ctrl.profile.value == null) {
                    return const Center(child: Text("Profil tidak ditemukan"));
                  }
                  return DataSupirProfile(data: ctrl.profile.value!);
                }),
              ),

              const SizedBox(height: 24),

              // — List Laporan —
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.05,
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Obx(() {
                    if (ctrl.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (ctrl.laporanList.isEmpty) {
                      return const Center(child: Text('Belum ada laporan.'));
                    }
                    return ListView.builder(
                      itemCount: ctrl.laporanList.length,
                      itemBuilder: (_, i) => LaporanItem(data: ctrl.laporanList[i]),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
