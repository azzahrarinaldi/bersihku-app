// ignore_for_file: avoid_print

import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LaporanMasukController extends GetxController {
  // Semua data laporan dari Firestore
  final laporanList = <DetailLaporanModel>[].obs;

  // Data yang sudah difilter berdasarkan wilayah
  final filteredList = <DetailLaporanModel>[].obs;

  // List nama wilayah yang tersedia
  final wilayahList = <String>[].obs;

  // Wilayah yang sedang dipilih
  final selectedWilayah = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Ambil data laporan saat controller pertama kali aktif
  }

  // Fungsi untuk ambil data laporan dari Firestore
  Future<void> fetchData() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .get(); // Ambil semua dokumen dari koleksi

      final temp = <DetailLaporanModel>[];
      final wilayahSet = <String>{'Semua'}; // Set biar nggak ada duplikat wilayah

      for (var doc in snap.docs) {
        final data = doc.data();

        // Ambil info user yang bikin laporan
        final userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(data['userId'])
            .get();

        final userData = userSnap.data() ?? {};
        data['name'] = userData['name'] ?? 'Unknown';
        data['profile_picture'] = userData['profile_picture'] ?? '';

        // Convert data jadi model DetailLaporanModel
        final lap = DetailLaporanModel.fromMap(data, doc.id);

        temp.add(lap); // Masukkan ke list sementara
        wilayahSet.add(lap.place); // Tambahkan wilayah ke set
      }

      // Urutkan data dari yang terbaru
      temp.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Masukkan hasilnya ke observable
      laporanList.assignAll(temp);
      filteredList.assignAll(temp);
      wilayahList.assignAll(wilayahSet);
      selectedWilayah.value = 'Semua';

      print("==> Got ${temp.length} laporan (sorted newest first)");
    } catch (e, st) {
      print('Error fetchData: $e\n$st'); // Debug kalau error
    }
  }

  // Fungsi untuk ganti filter wilayah
  void updateWilayah(String newWilayah) {
    selectedWilayah.value = newWilayah;

    if (newWilayah == 'Semua') {
      filteredList.assignAll(laporanList); // Tampilkan semua kalau "Semua" dipilih
    } else {
      // Filter berdasarkan wilayah
      filteredList.assignAll(
        laporanList.where((l) => l.place == newWilayah),
      );
    }
  }

  // Hitung jumlah laporan dari nama tertentu
  int countByName(String name) {
    return laporanList.where((l) => l.name == name).length;
  }
}
