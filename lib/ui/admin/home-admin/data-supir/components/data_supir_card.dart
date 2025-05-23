import 'package:bersihku/const.dart';
import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataSupirCard extends StatelessWidget {
  final DetailLaporanModel driver;
  final VoidCallback? onTapDetail;

  const DataSupirCard({
    super.key,
    required this.driver,
    this.onTapDetail,
  });

  String formatDate(DateTime date) =>
      DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(date);

  @override
  Widget build(BuildContext context) {
    if (driver.id.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: driver.profilePicture.isNotEmpty
                  ? NetworkImage(driver.profilePicture)
                  : const AssetImage('assets/images/profile-laporan-img.png')
                      as ImageProvider,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(driver.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 4),
                  const Text('Belum ada laporan',
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: driver.profilePicture.isNotEmpty
                      ? NetworkImage(driver.profilePicture)
                      : const AssetImage(
                              'assets/images/profile-laporan-img.png')
                          as ImageProvider,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(driver.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black)),
                    Text(driver.vehicle,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ]),
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

          const SizedBox(height: 18),
          const Text("Pengangkutan Terakhir",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 18),

          // tanggal & tempat dengan Expanded + ellipsis
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(children: [
              Expanded(
                flex: 2,
                child: Text(formatDate(driver.createdAt),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14)),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Text(
                  driver.place.isNotEmpty ? driver.place : 'Tidak diketahui',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
