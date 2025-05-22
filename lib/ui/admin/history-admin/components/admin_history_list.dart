import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:flutter/material.dart';
import 'admin_history_card.dart';

class AdminHistoryList extends StatelessWidget {
  final List<DetailLaporanModel> data;
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
    return ListView.separated(
      itemCount: data.length,
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemBuilder: (_, i) => AdminHistoryCard(data: data[i]),
    );
  }
}
