import 'package:flutter/material.dart';

class RincianPengangkutan extends StatelessWidget {
  final String place;
  final String address;
  final String time;
  final String weightTotal;

  const RincianPengangkutan({super.key, required this.place, required this.address, required this.time, required this.weightTotal});

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
        _buildDetail("Wilayah Pengangkutan", place),
        _buildDetail("Alamat", address),
        _buildDetail("Tanggal & Waktu Pengangkutan", time),
        _buildDetail("Total Berat Keseluruhan", weightTotal),
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