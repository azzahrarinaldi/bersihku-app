import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';
import 'package:bersihku/models/card_data_model.dart';

class PengangkutanCard extends StatelessWidget {
  final CardDataModel data;
  final String imageAsset;
  final VoidCallback? onTapDetail;

  const PengangkutanCard({
    super.key,
    required this.data,
    required this.imageAsset,
    this.onTapDetail,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    String day = data.date.split(',')[0];
    String date = data.date.split(',')[1].trim();

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
                      Text(
                        data.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      Text(data.vehicle,
                          style: const TextStyle(color: Colors.grey)),
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
          Text(
            data.place,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Text(data.address, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$day\n$date", textAlign: TextAlign.center),
                Text(data.time),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pengangkutan Sampah",
                style: TextStyle(
                    color: textSecondary, fontWeight: FontWeight.bold),
              ),
              Text(
                "${data.weight} Kg",
                style: const TextStyle(
                    color: textSecondary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
