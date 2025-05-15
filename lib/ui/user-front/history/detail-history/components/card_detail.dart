import 'package:bersihku/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bersihku/ui/user-front/history/detail-history/components/card_image.dart';
import 'package:bersihku/ui/user-front/history/detail-history/components/notes.dart';
import 'package:bersihku/ui/user-front/history/detail-history/components/total_wight.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CardDetailHistory extends StatefulWidget {
  final String documentId;
  const CardDetailHistory({super.key, required this.documentId});

  @override
  State<CardDetailHistory> createState() => _CardDetailHistoryState();
}

class _CardDetailHistoryState extends State<CardDetailHistory> {
  Map<String, dynamic>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null); // Inisialisasi lokal ID
    fetchData();
  }

  Future<void> fetchData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final laporanRef = FirebaseFirestore.instance
        .collection('laporan_pengangkutan')
        .doc(widget.documentId);
    final laporanSnapshot = await laporanRef.get();

    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userSnapshot = await userRef.get();

    final laporanData = laporanSnapshot.data();
    DateTime? createdAt;
    String? tanggalFormatted;
    String? waktuFormatted;

    if (laporanData?['created_at'] != null) {
      Timestamp timestamp = laporanData!['created_at'];
      createdAt = timestamp.toDate();

      // Format: Rabu, 26 Februari 2025
      tanggalFormatted = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(createdAt);

      // Format: 07:50 WIB
      waktuFormatted = DateFormat('HH:mm', 'id_ID').format(createdAt) + ' WIB';
    }

    setState(() {
      data = {
        ...?laporanData,
        'name': userSnapshot.data()?['name'],
        'tanggal': tanggalFormatted,
        'waktu': waktuFormatted,
      };
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (data == null) return const Center(child: Text("Data tidak ditemukan"));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil User
            Row(
              children: [
                Image.asset("assets/images/profile-person-history.png", width: 60),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!['name'] ?? "Nama tidak ditemukan",
                      style: const TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: textColor
                      ),
                    ),
                    Text(
                      data!['plat_nomor'] ?? "B 1829 POP",
                      style: const TextStyle(
                        fontSize: 13, 
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Alamat & Jadwal
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data!['lokasi'] ?? "",
                  style: const TextStyle(
                    fontSize: 15, 
                    fontWeight: FontWeight.w600,
                    color: textColor
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  data!['alamat'] ?? "",
                  style: const TextStyle(
                    fontSize: 11, 
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data!['tanggal'] ?? "Rabu, 26 Februari 2025", 
                      style: const TextStyle(
                        fontSize: 12, 
                        fontWeight: FontWeight.w600
                      )
                    ),
                    Text(
                      data!['waktu'] ?? "07:50 WIB", 
                      style: const TextStyle(
                        fontSize: 12, 
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CardImage(
                  imagesBasah: List<String>.from(data!['images_basah'] ?? []),
                  imagesKering: List<String>.from(data!['images_kering'] ?? []),
                ),
                const SizedBox(height: 25),
                TotalWight(total: data!["berat_keseluruhan"]),
                const SizedBox(height: 22),
                NotesDetailHistory(note: data!['catatan'] ?? "Tidak Ada Catatan"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
