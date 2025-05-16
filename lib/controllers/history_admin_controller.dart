// lib/controllers/history_admin_controller.dart

import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryAdminController extends GetxController {
  // Semua laporan
  final allLaporan = <DetailLaporanModel>[].obs;

  // Hasil filter (hari/bulan + search)
  final filteredLaporanList = <DetailLaporanModel>[].obs;

  final isDaily = true.obs;
  // Default ke bulan saat ini
  final selectedBulan = DateFormat('MMMM', 'id').format(DateTime.now()).obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLaporan();
  }

  Future<void> fetchLaporan() async {
    try {
      // 1) Ambil dokumen laporan
      final snapshot = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .orderBy('created_at', descending: true)
          .get();

      final temp = <DetailLaporanModel>[];

      // 2) Loop & inject data user ke raw map
      for (var doc in snapshot.docs) {
        // buat salinan data supaya aman dimodifikasi
        final raw = Map<String, dynamic>.from(doc.data());

        // ambil userId dari laporan
        final userId = raw['userId'] as String? ?? '';

        if (userId.isNotEmpty) {
          // fetch dokumen user
          final userSnap = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
          final userData = userSnap.data() ?? {};

          // inject name & profile_picture
          raw['name'] = userData['name'] ?? 'Unknown';
          raw['profile_picture'] = userData['profile_picture'] ?? '';
        } else {
          raw['name'] = 'Unknown';
          raw['profile_picture'] = '';
        }

        // 3) buat model dari raw yang sudah diperbarui
        temp.add(DetailLaporanModel.fromMap(raw, doc.id));
      }

      // 4) assign ke observable & filter
      allLaporan.assignAll(temp);
      filteredLaporanList.assignAll(temp);
      filterCardData();
    } catch (e, st) {
      print('Error fetchLaporan: $e\n$st');
    }
  }

  /// Panggil ini tiap kali isDaily / selectedBulan / searchQuery berubah
  void filterCardData() {
    final q = searchQuery.value.toLowerCase();
    final bulanFilter = selectedBulan.value.toLowerCase();
    final daily = isDaily.value;

    final hasil = allLaporan.where((lap) {
      // 1) Filter harian / bulanan
      if (!daily) {
        final bulanLap = DateFormat('MMMM', 'id')
            .format(lap.createdAt)
            .toLowerCase();
        if (bulanLap != bulanFilter) return false;
      }
      // 2) Filter berdasarkan nama atau tempat
      final teks = '${lap.name} ${lap.place}'.toLowerCase();
      return teks.contains(q);
    }).toList();

    filteredLaporanList.assignAll(hasil);
  }
}
