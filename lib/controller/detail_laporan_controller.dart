import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailLaporanController extends GetxController {
  var laporanList = <DetailLaporanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();   // langsung fetch data pas controller di-init
  }

  Future<void> fetchData() async {
    try {
      // 1) Ambil semua dokumen dari koleksi laporan_pengangkutan
      final snap = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .get();

      final temp = <DetailLaporanModel>[];

      for (var doc in snap.docs) {
        final data = Map<String, dynamic>.from(doc.data());  

        // 2) Fetch user-nya dulu
        final userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(data['userId'])
            .get();
        final userData = userSnap.data() ?? {};

        // 3) Merge nama & foto profil ke data laporan
        data['name'] = userData['name'] ?? 'Unknown';
        data['profile_picture'] = userData['profile_picture'] ?? '';

        // 4) Convert map jadi model dan simpan ke list sementara
        temp.add(DetailLaporanModel.fromMap(data, doc.id));
      }

      // 5) Update reactive list supaya UI auto-refresh
      laporanList.assignAll(temp);
    } catch (e, st) {
      // kalau error, print aja untuk debugging
      print('Error fetchData DetailLaporanController: $e\n$st');
    }
  }

  // helper buat ambil satu laporan by id
  DetailLaporanModel? getLaporanById(String id) {
    return laporanList.firstWhereOrNull((laporan) => laporan.id == id);
  }

  // helper buat hitung jumlah laporan berdasarkan nama user
  int getJumlahLaporanByUserId(String name) {
    return laporanList.where((l) => l.name == name).length;
  }
}
