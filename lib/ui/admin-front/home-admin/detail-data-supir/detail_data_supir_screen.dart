import 'package:bersihku/controllers/detail_data_supir_controller.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-data-supir/components/data_supir_header.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-data-supir/components/data_supir_profile.dart';
import 'package:bersihku/ui/admin-front/home-admin/detail-data-supir/components/laporan_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bersihku/const.dart';

class DetailDataSupirScreen extends StatelessWidget {
  const DetailDataSupirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    final controller = Get.put(DetailDataSupirController());

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
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: controller.laporanList.length,
                      itemBuilder: (context, index) {
                        final laporan = controller.laporanList[index];
                        return LaporanItem(laporan: laporan);
                      },
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
