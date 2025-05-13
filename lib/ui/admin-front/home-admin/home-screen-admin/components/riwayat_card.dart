import 'package:bersihku/models/riwayat_card_model.dart';
import 'package:flutter/material.dart';

class RiwayatCard extends StatelessWidget {
  const RiwayatCard({super.key, required this.data});
  final RiwayatCardModel data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    // Ukuran font responsif
    double baseFontSize = screenWidth * 0.04; // 4% dari lebar layar
    double smallFontSize = screenWidth * 0.035;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(width: 2, height: 30, color: Colors.white),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
              ),
              Container(width: 2, height: 70, color: Colors.white),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.place,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: baseFontSize,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.address,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: smallFontSize,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.date,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          data.time,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
