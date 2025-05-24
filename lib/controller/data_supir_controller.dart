import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataSupirController extends GetxController {
  // Observable list—setiap kali isinya berubah, UI yang “meng-observe” juga otomatis update
  var drivers = <DetailLaporanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToDrivers(); // Panggil method untuk mulai “dengarkan” data Firestore
  }

  void listenToDrivers() {
    FirebaseFirestore.instance
      .collection('laporan_pengangkutan')
      .orderBy('created_at', descending: true)
      .snapshots()
      .listen((snapshot) async {  // Pasang listener: tiap ada update Firestore, blok ini jalan
        final allModels = <DetailLaporanModel>[];

        for (var doc in snapshot.docs) {
          // 1) Ambil data mentah dari tiap dokumen snapshot
          final laporanData = Map<String, dynamic>.from(doc.data());

          // 2) Kalau ada userId, fetch data user dari koleksi 'users'
          final userId = laporanData['userId'] as String?;
          if (userId != null && userId.isNotEmpty) {
            final userSnap = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get(); 
            final userData = userSnap.data();
            if (userData != null) {
              // Merge nama & foto profile user ke dalam map laporan
              laporanData['name'] = userData['name'] ?? '';
              laporanData['profile_picture'] = userData['profile_picture'] ?? '';
            }
          }

          // 3) Convert map yang sudah di-merge tadi jadi model DetailLaporanModel
          final model = DetailLaporanModel.fromMap(laporanData, doc.id);
          allModels.add(model);
        }

        // 4) Filter nama unik: hanya ambil satu model pertama untuk tiap nama
        final unique = <String, DetailLaporanModel>{};
        for (var m in allModels) {
          if (!unique.containsKey(m.name)) {
            unique[m.name] = m;
          }
        }

        // 5) Update observable sehingga UI otomatis refresh
        drivers.value = unique.values.toList();
    });
  }
}
