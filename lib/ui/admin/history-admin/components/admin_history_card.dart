import 'package:bersihku/const.dart';
import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:bersihku/ui/admin/history-admin/components/history_image_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminHistoryCard extends StatelessWidget {
  final DetailLaporanModel data;

  const AdminHistoryCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // format tanggal & waktu
    final formattedDate =
        DateFormat('EEEE, d MMMM yyyy', 'id').format(data.createdAt);
    final formattedTime = DateFormat('HH:mm', 'id').format(data.createdAt);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: avatar, nama, kendaraan
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                backgroundImage: data.profilePicture.isNotEmpty
                    ? NetworkImage(data.profilePicture)
                    : null,
                child: data.profilePicture.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.grey[600],
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.vehicle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Lokasi & Alamat
          Text(
            data.place,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.address,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 18),

          // Tanggal & Waktu
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formattedDate,
                    style: const TextStyle(fontSize: 12, color: textColor)),
                Text(formattedTime,
                    style: const TextStyle(fontSize: 12, color: textColor)),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Gallery gambar
          HistoryImageCard(
            imagesKering: data.imagesKering,
            imagesBasah: data.imagesBasah,
          ),

          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Sampah Basah",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              Text(
                '${data.formattedWeightBasah} Kg',
                style: const TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Sampah Kering",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              Text(
                '${data.formattedWeightKering} Kg',
                style: const TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Berat sampah
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Semua Sampah',
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${data.formattedWeight} Kg',
                style: const TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
