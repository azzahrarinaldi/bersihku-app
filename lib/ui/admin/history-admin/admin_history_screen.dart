// ignore_for_file: deprecated_member_use

import 'package:bersihku/ui/admin/history-admin/components/toggle_button_reprt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:bersihku/const.dart';
import 'package:bersihku/controller/history_admin_controller.dart';
import 'package:bersihku/controller/pdf_generator_controller.dart';
import 'components/dropdown_bulan.dart';
import 'components/dropdown_wilayah_history.dart';
import 'components/admin_history_list.dart';

class AdminHistoryScreen extends StatelessWidget {
  const AdminHistoryScreen({super.key});

  final List<String> bulanList = const [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  Widget build(BuildContext context) {
    final historyCtrl = Get.put(HistoryAdminController());
    final pdfCtrl = Get.put(PdfGeneratorController());
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🎯 Title
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.05,
                    vertical: 15,
                  ),
                  child: const Text(
                    'Riwayat Laporan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // 🔍 Search bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (v) {
                              historyCtrl.searchQuery.value = v;
                              historyCtrl.filterCardData();
                            },
                            decoration: const InputDecoration(
                              hintText: 'Cari Riwayat..',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const Icon(Icons.search, color: Colors.white),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 📊 Toggle Harian / Bulanan
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                          child: ToggleButtonReport(
                              ctrl: historyCtrl,
                              daily: true,
                              label: 'Laporan Harian')),
                      const SizedBox(width: 10),
                      Expanded(
                          child: ToggleButtonReport(
                              ctrl: historyCtrl,
                              daily: false,
                              label: 'Laporan Bulanan')),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 🗂 Konten putih: dropdown, button, list
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dropdown Bulan & Wilayah
                          Obx(() {
                            if (!historyCtrl.isDaily.value) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: DropdownBulan(
                                      selectedBulan:
                                          historyCtrl.selectedBulan.value,
                                      bulanList: bulanList,
                                      onChanged: (v) {
                                        historyCtrl.selectedBulan.value = v;
                                        historyCtrl.filterCardData();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 2,
                                    child: DropDownWilayahHistory(
                                      selectedWilayah:
                                          historyCtrl.selectedWilayah.value,
                                      wilayahList:
                                          historyCtrl.wilayahList.toList(),
                                      onChanged: (v) =>
                                          historyCtrl.updateWilayah(v),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          }),

                          const SizedBox(height: 16),

                          // Generate PDF / Loading
                          Obx(() {
                            if (historyCtrl.isDaily.value)
                              return const SizedBox.shrink();
                            if (pdfCtrl.isGenerating.value) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballPulse,
                                    colors: [
                                      Color(0xFF9AE2FF),
                                      Color(0xFFF9E071),
                                      Color(0xFFF29753),
                                    ],
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }
                            return Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => pdfCtrl.generatePdfFile(
                                  laporanList:
                                      historyCtrl.filteredLaporanList.toList(),
                                  selectedBulan:
                                      historyCtrl.selectedBulan.value,
                                  selectedWilayah:
                                      historyCtrl.selectedWilayah.value,
                                  isDaily: historyCtrl.isDaily.value,
                                ),
                                child: const Text(
                                  'Generate PDF',
                                  style: TextStyle(
                                    color: Color(0xFFF29753),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFF29753),
                                  ),
                                ),
                              ),
                            );
                          }),

                          const SizedBox(height: 16),

                          // List Riwayat
                          Expanded(
                            child: Obx(() => AdminHistoryList(
                                  data:
                                      historyCtrl.filteredLaporanList.toList(),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
