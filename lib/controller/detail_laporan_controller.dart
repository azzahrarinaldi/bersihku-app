// controllers/detail_laporan_controller.dart
import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailLaporanController extends GetxController {
  var laporanList = <DetailLaporanModel>[].obs;

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

        temp.add(DetailLaporanModel.fromMap(data, doc.id));
      }
      laporanList.assignAll(temp);
    } catch (e, st) {
      print('Error fetchData DetailLaporanController: $e\n$st');
    }
  }

  DetailLaporanModel? getLaporanById(String id) {
    return laporanList.firstWhereOrNull((laporan) => laporan.id == id);
  }

  int getJumlahLaporanByUserId(String name) {
    return laporanList.where((l) => l.name == name).length;
  }
}