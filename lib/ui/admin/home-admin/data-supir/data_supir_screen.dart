import 'package:bersihku/controller/data_supir_controller.dart';
import 'package:bersihku/ui/admin/home-admin/data-supir/components/data_supir_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bersihku/const.dart';

class DataSupirScreen extends StatelessWidget {
  const DataSupirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final driverController = Get.put(DataSupirController());

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/orange-pattern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
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
                    ),
                  ],
                ),
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
                    final list = driverController.drivers;
                    if (list.isEmpty) {
                      return const Center(child: Text("Belum ada data supir."));
                    }
                    return ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (_, i) {
                        final driver = list[i];
                        return DataSupirCard(
                          driver: driver,
                          onTapDetail: () {
                            // PENTING: kita kirim userId, bukan docId
                            Get.toNamed(
                              '/detail-data-supir',
                              arguments: driver.userId,
                            );
                          },
                        );
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
