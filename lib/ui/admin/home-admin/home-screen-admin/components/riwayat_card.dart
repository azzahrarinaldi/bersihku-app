import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:bersihku/models/riwayat_card_model.dart';

class RiwayatCard extends StatelessWidget {
  const RiwayatCard({
    super.key,
    required this.data,
    required this.isFirst,
    required this.isLast,
  });

  final RiwayatCardModel data;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: const IndicatorStyle(
        width: 15,
        color: Colors.white,
        indicatorXY: 0.3,
      ),
      beforeLineStyle: const LineStyle(
        color: Colors.white,
        thickness: 2,
      ),
      afterLineStyle: const LineStyle(
        color: Colors.white,
        thickness: 2,
      ),
      endChild: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            // ignore: deprecated_member_use
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.place,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                data.address,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 10),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Warna border
                  borderRadius: BorderRadius.circular(10), // Radius sudut
                  color: Colors.white, // Warna latar (opsional)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.date, style: const TextStyle(fontSize: 12)),
                    Text(data.time, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}