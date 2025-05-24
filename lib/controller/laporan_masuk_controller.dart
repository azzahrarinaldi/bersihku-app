// ignore_for_file: avoid_print

import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LaporanMasukController extends GetxController {
  final laporanList = <DetailLaporanModel>[].obs;
  final filteredList = <DetailLaporanModel>[].obs;
  final wilayahList = <String>[].obs;
  final selectedWilayah = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .get();

      final temp = <DetailLaporanModel>[];
      final wilayahSet = <String>{'Semua'};

      for (var doc in snap.docs) {
        final data = doc.data();

        // AMANIN user data
        final userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(data['userId'])
            .get();
        final userData = userSnap.data() ?? {};
        data['name'] = userData['name'] ?? 'Unknown';
        data['profile_picture'] = userData['profile_picture'] ?? '';

        // build model pakai factory yang sudah safe
        final lap = DetailLaporanModel.fromMap(data, doc.id);

        temp.add(lap);
        wilayahSet.add(lap.place);
      }

      // **Sort terbaru dulu (descending by createdAt)**
      temp.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Assign setelah di‑sort
      laporanList.assignAll(temp);
      filteredList.assignAll(temp);
      wilayahList.assignAll(wilayahSet);
      selectedWilayah.value = 'Semua';

      print("==> Got ${temp.length} laporan (sorted newest first)");
    } catch (e, st) {
      print('Error fetchData: $e\n$st');
    }
  }

  void updateWilayah(String newWilayah) {
    selectedWilayah.value = newWilayah;
    if (newWilayah == 'Semua') {
      filteredList.assignAll(laporanList);
    } else {
      filteredList.assignAll(
        laporanList.where((l) => l.place == newWilayah),
      );
    }
  }

  int countByName(String name) {
    return laporanList.where((l) => l.name == name).length;
  }
}
