import 'package:bersihku/models/card_history_model.dart';
import 'package:flutter/material.dart';
import 'admin_history_card.dart';

class AdminHistoryList extends StatelessWidget {
  final List<CardDataModel> data;

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
        return Column(
          children: [
            AdminHistoryCard(data: data[index]),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}