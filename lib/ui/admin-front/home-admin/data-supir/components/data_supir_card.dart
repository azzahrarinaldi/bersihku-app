import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';

class DataSupirCard extends StatelessWidget {
  final String name;
  final String code;
  final String pengangkutanText;
  final String day;
  final String date;
  final String time;
  final String imageAsset;
  final VoidCallback? onTapDetail;

  const DataSupirCard({
    super.key,
    required this.name,
    required this.code,
    required this.pengangkutanText,
    required this.day,
    required this.date,
    required this.time,
    required this.imageAsset,
    this.onTapDetail,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(imageAsset),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                      Text(code, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTapDetail,
                child: const Text(
                  "Lihat Detail",
                  style: TextStyle(
                      color: textSecondary, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: secondaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(pengangkutanText,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
                  const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(textAlign: TextAlign.center, "$day\n$date"), Text(time),],
            ),
          ),
        ],
      ),
    );
  }
}