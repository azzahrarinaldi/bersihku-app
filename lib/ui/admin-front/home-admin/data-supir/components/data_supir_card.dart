import 'package:bersihku/models/data_supir_card.dart';
import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';

class DataSupirCard extends StatelessWidget {
  final DriverModel driver;
  final String imageAsset;
  final VoidCallback? onTapDetail;

  const DataSupirCard({
    super.key,
    required this.driver,
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
                      Text(driver.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                      Text(driver.vehicle, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTapDetail,
                child: const Text(
                  "Lihat Detail",
                  style: TextStyle(
                    color: textSecondary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: secondaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(driver.place,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
          const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_getDayFromDate(driver.date)}\n${driver.date}",
                  textAlign: TextAlign.center,
                ),
                Text(driver.time),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to extract day name if needed
  String _getDayFromDate(String dateStr) {
    // Dummy logic. Replace this with actual parsing if needed
    // E.g., "26 Februari 2025" => "Rabu"
    return "Hari";
  }
}
