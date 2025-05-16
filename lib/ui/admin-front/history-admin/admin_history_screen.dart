import 'package:bersihku/const.dart';
import 'package:bersihku/controllers/history_admin_controller.dart';
import 'package:bersihku/ui/admin-front/history-admin/components/admin_history_list.dart';
import 'package:bersihku/ui/admin-front/history-admin/components/dropdown_bulan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHistoryScreen extends StatelessWidget {
  AdminHistoryScreen({Key? key}) : super(key: key);

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
    final ctrl = Get.put(HistoryAdminController());
    final screenWidth = MediaQuery.of(context).size.width;

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
              // Title
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
              // Search
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
                          onChanged: (v) {
                            ctrl.searchQuery.value = v;
                            ctrl.filterCardData();
                          },
                          decoration: const InputDecoration(
                            hintText: "Cari Riwayat..",
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
              // Toggle Harian / Bulanan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(child: _buildToggleButton(ctrl, true, "Laporan Harian")),
                    const SizedBox(width: 10),
                    Expanded(child: _buildToggleButton(ctrl, false, "Laporan Bulanan")),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Content list
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,  // <- tambahkan ini
                      children: [
                        Obx(() {
                          if (!ctrl.isDaily.value) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),  // geser 8px dari kiri
                                child: DropdownBulan(
                                  selectedBulan: ctrl.selectedBulan.value,
                                  bulanList: bulanList,
                                  onChanged: (newVal) {
                                    ctrl.selectedBulan.value = newVal;
                                    ctrl.filterCardData();
                                  },
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Obx(() {
                            return AdminHistoryList(
                              data: ctrl.filteredLaporanList.toList(),
                            );
                          }),
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

  Widget _buildToggleButton(HistoryAdminController ctrl, bool daily, String label) {
    return Obx(() {
      final sel = ctrl.isDaily.value == daily;
      return GestureDetector(
        onTap: () {
          ctrl.isDaily.value = daily;
          ctrl.filterCardData();
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: sel ? const Color(0xFFFDD835) : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: sel ? Colors.black87 : Colors.white,
                fontWeight: sel ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    });
  }
}