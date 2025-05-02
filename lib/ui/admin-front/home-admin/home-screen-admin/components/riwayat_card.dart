import 'package:flutter/material.dart';

class RiwayatCard extends StatelessWidget {
  const RiwayatCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
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
                      color: Colors.white, shape: BoxShape.circle)),
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
                    "Kemang Village Apartment",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(textAlign: TextAlign.center,"Rabu\n26 Februari 2025"),
                        Text("21.00 - 06.00"),
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