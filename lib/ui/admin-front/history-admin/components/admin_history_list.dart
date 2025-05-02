import 'package:flutter/material.dart';
import 'admin_history_card.dart';

class AdminHistoryList extends StatelessWidget {
  final List<Map<String, String>> data;

  const AdminHistoryList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text(
          "Tidak ada data untuk laporan ini.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Column(
          children: [
            AdminHistoryCard(
              name: item["name"]!,
              vehicle: item["vehicle"]!,
              place: item["place"]!,
              address: item["address"]!,
              date: item["date"]!,
              time: item["time"]!,
              type: item["type"]!,
              weight: item["weight"]!,
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}