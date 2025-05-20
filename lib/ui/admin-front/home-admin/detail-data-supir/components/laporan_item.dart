// components/laporan_item.dart

import 'package:bersihku/models/detail_data_supir_model.dart';
import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';
import 'package:intl/intl.dart';

class LaporanItem extends StatelessWidget {
  final DetailDataSupirModel data;
  const LaporanItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final date = DateFormat('EEEE, d MMMM yyyy', 'id').format(data.createdAt);
    final time = DateFormat('HH:mm').format(data.createdAt);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.place, 
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w500,
              color: textColor
            )
          ),
          const SizedBox(height: 8),
          Text(
            data.address, 
            style: const TextStyle(
              fontSize: 14, 
              color: Colors.black54
            )
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: w * 0.07, vertical: 11),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date, 
                  style: const TextStyle(fontSize: 14)
                ),
                Text(
                  time, 
                  style: const TextStyle(fontSize: 14)
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pengangkutan Sampah',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: textSecondary
                )
              ),
              Text(
                '${data.formattedWeight} Kg',
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: textSecondary
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
