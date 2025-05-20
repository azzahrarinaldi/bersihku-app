import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryDetailModel {
  final String name;
  final String platNomor;
  final String lokasi;
  final String alamat;
  final String tanggal;
  final String waktu;
  final List<String> imagesBasah;
  final List<String> imagesKering;
  final String beratKeseluruhan;
  final String catatan;

  HistoryDetailModel({
    required this.name,
    required this.platNomor,
    required this.lokasi,
    required this.alamat,
    required this.tanggal,
    required this.waktu,
    required this.imagesBasah,
    required this.imagesKering,
    required this.beratKeseluruhan,
    required this.catatan,
  });

  factory HistoryDetailModel.fromFirestore(DocumentSnapshot doc, String userName) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    Timestamp? timestamp = data['created_at'] as Timestamp?;
    DateTime? createdAt = timestamp?.toDate();

    String tanggalFormatted = '';
    String waktuFormatted = '';

    if (createdAt != null) {
      tanggalFormatted = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(createdAt);
      waktuFormatted = "${DateFormat('HH:mm', 'id_ID').format(createdAt)} WIB";
    }

    return HistoryDetailModel(
      name: userName,
      platNomor: data['plat_nomor'] ?? 'N/A',
      lokasi: data['lokasi'] ?? '',
      alamat: data['alamat'] ?? '',
      tanggal: tanggalFormatted,
      waktu: waktuFormatted,
      imagesBasah: List<String>.from(data['images_basah'] ?? []),
      imagesKering: List<String>.from(data['images_kering'] ?? []),
      beratKeseluruhan: data['berat_keseluruhan']?.toString() ?? '0',
      catatan: data['catatan'] ?? 'Tidak Ada Catatan',
    );
  }
}