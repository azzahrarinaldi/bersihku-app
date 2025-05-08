import 'package:bersihku/const.dart';
import 'package:bersihku/controllers/card_history_controller.dart';
import 'package:bersihku/ui/admin-front/history-admin/components/admin_history_list.dart';
import 'package:bersihku/ui/admin-front/history-admin/components/dropdown_bulan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHistoryScreen extends StatelessWidget {
  AdminHistoryScreen({super.key});

  final cardController = Get.find<CardController>();

  final List<String> bulanList = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: 15,
                ),
                child: const Text(
                  "Riwayat Laporan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        onChanged: (value) {
                          cardController.searchQuery.value = value;
                          cardController.filterCardData();
                        },
                        decoration: InputDecoration(
                          hintText: "Cari Riwayat..",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      )),
                      Icon(Icons.search, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return GestureDetector(
                          onTap: () {
                            cardController.isDaily.value = true;
                            cardController.filterCardData();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: cardController.isDaily.value
                                  ? const Color(0xFFFDD835)
                                  : Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Laporan Harian",
                                style: TextStyle(
                                  color: cardController.isDaily.value
                                      ? Colors.black87
                                      : Colors.white,
                                  fontWeight: cardController.isDaily.value
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() {
                        return GestureDetector(
                          onTap: () {
                            cardController.isDaily.value = false;
                            cardController.filterCardData();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: !cardController.isDaily.value
                                  ? const Color(0xFFFDD835)
                                  : Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Laporan Bulanan",
                                style: TextStyle(
                                  color: !cardController.isDaily.value
                                      ? Colors.black87
                                      : Colors.white,
                                  fontWeight: !cardController.isDaily.value
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Obx(() {
                          if (!cardController.isDaily.value) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownBulan(
                                  selectedBulan:
                                      cardController.selectedBulan.value,
                                  bulanList: bulanList,
                                  onChanged: (newBulan) {
                                    cardController.selectedBulan.value =
                                        newBulan;
                                    cardController.filterCardData();
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    // handle PDF generation
                                  },
                                  child: Text(
                                    "Generate PDF",
                                    style: TextStyle(
                                      color: textSecondary,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                        const SizedBox(height: 16),
                        Expanded(
                          child: GetX<CardController>(
                            builder: (controller) {
                              return AdminHistoryList(
                                data: controller.filteredCardList.toList(),
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
      ),
    );
  }
}
