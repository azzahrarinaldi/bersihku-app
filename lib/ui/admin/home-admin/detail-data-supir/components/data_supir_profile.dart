// data_supir_profile.dart

import 'package:bersihku/models/detail_data_supir_model.dart';
import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';

class DataSupirProfile extends StatelessWidget {
  final DetailDataSupirModel data;

  const DataSupirProfile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: data.profilePicture.isNotEmpty
                ? NetworkImage(data.profilePicture)
                : const AssetImage(
                    'assets/images/profile-laporan-img.png',
                  ) as ImageProvider,
          ),
          const SizedBox(height: 10),
          Text(
            data.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.phone,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFCFAA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data.vehicle,
              style: const TextStyle(
                color: textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
