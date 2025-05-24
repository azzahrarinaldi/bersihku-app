import 'package:bersihku/const.dart';
import 'package:flutter/material.dart';

class TotalWight extends StatelessWidget {
  final String total;
  const TotalWight({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final displayTotal = total.isNotEmpty ? total : "0.00";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Pengangkutan Sampah",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          "$displayTotal Kg",
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}