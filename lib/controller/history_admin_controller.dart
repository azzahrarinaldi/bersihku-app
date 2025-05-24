import 'package:get/get.dart';
import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryAdminController extends GetxController {
  // Semua data laporan yang diambil dari Firestore
  final allLaporan = <DetailLaporanModel>[].obs;

  // Data laporan setelah difilter (misalnya berdasarkan wilayah, bulan, atau pencarian)
  final filteredLaporanList = <DetailLaporanModel>[].obs;

  // Filter harian
  final isDaily = false.obs;

  // Bulan yang dipilih untuk filter (default: bulan sekarang)
  final selectedBulan = DateFormat('MMMM', 'id').format(DateTime.now()).obs;

  // Query pencarian (untuk cari berdasarkan nama atau tempat)
  final searchQuery = ''.obs;

  // List semua wilayah unik yang ada di laporan
  final wilayahList = <String>[].obs;

  // Wilayah yang sedang dipilih untuk filter (default: Semua)
  final selectedWilayah = 'Semua'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLaporan(); // Ambil data dari Firestore saat controller di-initialize
  }

  // Fungsi untuk ambil data laporan dari Firestore
  Future<void> fetchLaporan() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .orderBy('created_at', descending: true)
          .get();

      final temp = <DetailLaporanModel>[];

      for (var doc in snapshot.docs) {
        final raw = Map<String, dynamic>.from(doc.data());
        final userId = raw['userId'] as String? ?? '';

        // Cek apakah userId valid
        if (userId.isNotEmpty) {
          final userSnap = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
          final userData = userSnap.data() ?? {};
          raw['name'] = userData['name'] ?? 'Unknown';
          raw['profile_picture'] = userData['profile_picture'] ?? '';
        } else {
          raw['name'] = 'Unknown';
          raw['profile_picture'] = '';
        }

        // Convert data ke model
        temp.add(DetailLaporanModel.fromMap(raw, doc.id));
      }

      // Simpan data ke variabel observable
      allLaporan.assignAll(temp);
      filteredLaporanList.assignAll(temp);

      // Ambil semua wilayah unik untuk filter dropdown
      final wilayahSet = <String>{'Semua'};
      for (var lap in temp) {
        wilayahSet.add(lap.place);
      }
      wilayahList.assignAll(wilayahSet);
      selectedWilayah.value = 'Semua';

      // Jalankan filter awal
      filterCardData();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal fetch data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Fungsi untuk filter data berdasarkan pencarian, bulan, tanggal, dan wilayah
  void filterCardData() {
    final q = searchQuery.value.toLowerCase(); // keyword pencarian
    final bulanFilter = selectedBulan.value.toLowerCase(); // bulan filter
    final daily = isDaily.value;
    final wilayahFilter = selectedWilayah.value;

    final hasil = allLaporan.where((lap) {
      // Filter berdasarkan hari ini kalau daily true
      if (daily) {
        final now = DateTime.now();
        final isSameDay = lap.createdAt.year == now.year &&
            lap.createdAt.month == now.month &&
            lap.createdAt.day == now.day;
        if (!isSameDay) return false;
      } else {
        // Kalau bukan daily, filter berdasarkan bulan
        final bulanLap = DateFormat('MMMM', 'id').format(lap.createdAt).toLowerCase();
        if (bulanLap != bulanFilter) return false;
      }

      // Filter berdasarkan wilayah jika dipilih
      if (wilayahFilter != 'Semua' && lap.place != wilayahFilter) return false;

      // Filter berdasarkan nama atau tempat
      final teksGabungan = '${lap.name} ${lap.place}'.toLowerCase();
      return teksGabungan.contains(q);
    }).toList();

    filteredLaporanList.assignAll(hasil);
  }

  // Update wilayah yang dipilih dari dropdown
  void updateWilayah(String newWilayah) {
    selectedWilayah.value = newWilayah;
    filterCardData(); // setelah update, langsung filter ulang datanya
  }
}