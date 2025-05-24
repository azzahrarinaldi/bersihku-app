import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RekapanController extends GetxController {
  final totalBerat = 0.0.obs; // Total semua berat laporan bulan ini
  final wilayahTerbanyak = ''.obs; // Wilayah yang paling banyak jumlah beratnya

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Langsung ambil data pas controller aktif
  }

  Future<void> fetchData() async {
    try {
      final now = DateTime.now();
      final firstDayOfMonth = DateTime(now.year, now.month, 1); // Tanggal 1 bulan ini
      final ts = Timestamp.fromDate(firstDayOfMonth); // Convert ke Timestamp (Firestore)

      final snap = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .where('created_at', isGreaterThanOrEqualTo: ts)
          .get(); // Ambil laporan yang dibuat dari awal bulan ini

      double berat = 0; // Total semua berat
      final lokasiMap = <String, double>{}; // Map untuk nyimpan total berat per lokasi

      for (var doc in snap.docs) {
        final data = doc.data();
        final v = double.tryParse(data['berat_keseluruhan'].toString()) ?? 0;
        final loc = data['lokasi']?.toString() ?? 'Unknown';

        berat += v; // Tambah ke total berat
        lokasiMap[loc] = (lokasiMap[loc] ?? 0) + v; // Tambah berat ke lokasi yang sesuai
      }

      totalBerat.value = berat; // Simpan ke state

      if (lokasiMap.isNotEmpty) {
        // Ambil lokasi dengan total berat paling banyak
        wilayahTerbanyak.value = lokasiMap.entries
            .reduce((a, b) => a.value > b.value ? a : b)
            .key;
      } else {
        wilayahTerbanyak.value = 'Tidak ada data';
      }
    } catch (e) {
      // Kalau error, reset nilainya
      totalBerat.value = 0.0;
      wilayahTerbanyak.value = 'Error';
    }
  }
}