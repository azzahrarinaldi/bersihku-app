import 'package:flutter/material.dart';

class RincianPengangkutan extends StatelessWidget {
  const RincianPengangkutan({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rincian Pengangkutan:",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 15),
        _buildDetail("Wilayah Pengangkutan", "Margo City"),
        _buildDetail("Alamat", "Jl. Margonda Raya No.358, Kemiri Muka, Kecamatan Beji"),
        _buildDetail("Tanggal Pengangkutan", "Rabu, 26 Februari 2025"),
        _buildDetail("Waktu Pengangkutan", "Rabu, 26 Februari 2025"),
        _buildDetail("Total Berat Keseluruhan", "7.050"),
      ],
    );
  }

  Widget _buildDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 5),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
        const SizedBox(height: 15),
      ],
    );
  }
}