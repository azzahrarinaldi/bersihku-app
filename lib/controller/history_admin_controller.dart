import 'package:get/get.dart';
import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryAdminController extends GetxController {
  final allLaporan = <DetailLaporanModel>[].obs;
  final filteredLaporanList = <DetailLaporanModel>[].obs;

  final isDaily = false.obs;
  final selectedBulan = DateFormat('MMMM', 'id').format(DateTime.now()).obs;
  final searchQuery = ''.obs;

  final wilayahList = <String>[].obs;
  final selectedWilayah = 'Semua'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLaporan();
  }

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
        temp.add(DetailLaporanModel.fromMap(raw, doc.id));
      }

      allLaporan.assignAll(temp);
      filteredLaporanList.assignAll(temp);

      final wilayahSet = <String>{'Semua'};
      for (var lap in temp) {
        wilayahSet.add(lap.place);
      }
      wilayahList.assignAll(wilayahSet);
      selectedWilayah.value = 'Semua';

      filterCardData();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal fetch data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void filterCardData() {
    final q = searchQuery.value.toLowerCase();
    final bulanFilter = selectedBulan.value.toLowerCase();
    final daily = isDaily.value;
    final wilayahFilter = selectedWilayah.value;

    final hasil = allLaporan.where((lap) {
      if (!daily) {
        final bulanLap =
            DateFormat('MMMM', 'id').format(lap.createdAt).toLowerCase();
        if (bulanLap != bulanFilter) return false;
      }
      if (wilayahFilter != 'Semua' && lap.place != wilayahFilter) return false;
      final teks = '${lap.name} ${lap.place}'.toLowerCase();
      return teks.contains(q);
    }).toList();

    filteredLaporanList.assignAll(hasil);
  }

  void updateWilayah(String newWilayah) {
    selectedWilayah.value = newWilayah;
    filterCardData();
  }
}