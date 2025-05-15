import 'package:bersihku/const.dart';
import 'package:bersihku/controllers/rekapan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RekapanCard extends StatelessWidget {
  const RekapanCard({super.key});

  @override
  Widget build(BuildContext context) {
    // inisialisasi controller (sekali)
    final c = Get.put(RekapanController());

    return Obx(() => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: const [
                Icon(Icons.calendar_today_outlined, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "Rekapan Sampah Bulan Ini",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ]),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Berat",
                      style: TextStyle(color: Colors.black)),
                  _Badge(
                    text: "${NumberFormat("#,##0", "id_ID").format(c.totalBerat.value)} Kg",
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Wilayah Terbanyak",
                      style: TextStyle(color: Colors.black)),
                  _Badge(text: c.wilayahTerbanyak.value),
                ],
              ),
            ],
          ),
        ));
  }
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFCFAA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFCFAA)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}