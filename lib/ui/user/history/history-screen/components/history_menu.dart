import 'package:bersihku/ui/user/history/detail-history/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryMenu extends StatelessWidget {
  final String documentId;
  const HistoryMenu({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade200, width: 1.2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'detail') {
            Get.to(() => DetailScreenHistory.withTag(documentId));
          }
        },
        itemBuilder: (_) => [
          const PopupMenuItem(
            value: 'detail',
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Text('Detail', style: TextStyle(fontSize: 12)),
          ),
        ],
        icon: const Icon(Icons.more_vert, size: 18, color: Colors.black),
      ),
    );
  }
}