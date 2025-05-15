import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';
import 'package:intl/intl.dart';

class PengangkutanCard extends StatelessWidget {
  final DetailLaporanModel data;
  final VoidCallback? onTapDetail;

  const PengangkutanCard({
    super.key,
    required this.data,
    this.onTapDetail,
  });

  @override
  Widget build(BuildContext context) {
    // format tanggal & waktu
    final formattedDate = DateFormat('EEEE, d MMMM yyyy', 'id').format(data.createdAt);
    final formattedTime = DateFormat('HH:mm').format(data.createdAt);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              CircleAvatar(
                backgroundImage: data.profilePicture.isNotEmpty
                  ? NetworkImage(data.profilePicture)
                  : AssetImage('assets/images/profile-laporan-img.png')
                  as ImageProvider,
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
                      fontSize: 18,
                      color: textColor
                    )
                  ),
                  Text(
                    data.vehicle, 
                    style: const TextStyle(color: Colors.grey)
                  ),
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
                  decorationColor: secondaryColor
                )
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          data.place,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: textColor
          )
        ),
        const SizedBox(height: 8),
        Text(
          data.address, 
          style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate, 
                textAlign: TextAlign.center
              ),
              Text(formattedTime),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Pengangkutan Sampah",
              style: TextStyle(
                color: textSecondary, 
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              "${data.formattedWeight} Kg",
              style: const TextStyle(
                color: textSecondary,
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
        const SizedBox(height: 8)
      ]),
    );
  }
}