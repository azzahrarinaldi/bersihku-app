import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataSupirController extends GetxController {
  var drivers = <DetailLaporanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToDrivers();
  }

  void listenToDrivers() {
    FirebaseFirestore.instance
      .collection('laporan_pengangkutan')
      .orderBy('created_at', descending: true)
      .snapshots()
      .listen((snapshot) async {
        final allModels = <DetailLaporanModel>[];

        for (var doc in snapshot.docs) {
          // 1) ambil data laporan
          final laporanData = Map<String, dynamic>.from(doc.data());

          // 2) fetch user (jika ada)
          final userId = laporanData['userId'] as String?;
          if (userId != null && userId.isNotEmpty) {
            final userSnap = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
            final userData = userSnap.data();
            if (userData != null) {
              // merge nama & foto user ke dalam laporanData
              laporanData['name'] = userData['name'] ?? '';
              laporanData['profile_picture'] = userData['profile_picture'] ?? '';
            }
          }

          // 3) buat model dari merged map
          final model = DetailLaporanModel.fromMap(laporanData, doc.id);
          allModels.add(model);
        }

        // filter unique by name (ambil yang paling atas saja)
        final unique = <String, DetailLaporanModel>{};
        for (var m in allModels) {
          if (!unique.containsKey(m.name)) {
            unique[m.name] = m;
          }
        }

        drivers.value = unique.values.toList();
    });
  }
}