import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RekapanController extends GetxController {
  /// Rx variables untuk total berat dan wilayah terbanyak
  final totalBerat = 0.0.obs;
  final wilayahTerbanyak = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Panggil fetchData() otomatis saat controller siap
  }

  Future<void> fetchData() async {
    try {
      final now = DateTime.now();
      final firstDayOfMonth = DateTime(now.year, now.month, 1);
      // Gunakan Timestamp supaya query .where() valid
      final ts = Timestamp.fromDate(firstDayOfMonth);

      final snap = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .where('created_at', isGreaterThanOrEqualTo: ts)
          .get();

      // Hitung total berat_keseluruhan per dokumen
      double berat = 0;
      // Map lokasi → total berat untuk mencari yang terbesar
      final lokasiMap = <String, double>{};

      for (var doc in snap.docs) {
        final data = doc.data();
        // parse berat_keseluruhan apa pun tipenya
        final v = double.tryParse(data['berat_keseluruhan'].toString()) ?? 0;
        final loc = data['lokasi']?.toString() ?? 'Unknown';

        berat += v;
        lokasiMap[loc] = (lokasiMap[loc] ?? 0) + v;
      }

      totalBerat.value = berat;

      if (lokasiMap.isNotEmpty) {
        // cari entry dengan nilai terbesar
        wilayahTerbanyak.value = lokasiMap.entries
            .reduce((a, b) => a.value > b.value ? a : b)
            .key;
      } else {
        wilayahTerbanyak.value = 'Tidak ada data';
      }
    } catch (e) {
      totalBerat.value = 0.0;
      wilayahTerbanyak.value = 'Error';
    }
  }
}
