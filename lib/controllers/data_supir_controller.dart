import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverController extends GetxController {
  var drivers = <DetailLaporanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllDriversWithLastReport();
  }

  Future<void> loadAllDriversWithLastReport() async {
    // 1) Ambil hanya dokumen users dengan role == 'user'
    final userSnap = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'user')
        .orderBy('created_at', descending: true) // opsional
        .get();

    final List<DetailLaporanModel> list = [];

    for (var u in userSnap.docs) {
      final userData = u.data();
      final userId = u.id;

      // 2) Fetch laporan_pengangkutan terbaru untuk user ini
      final laporanQuery = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .where('userId', isEqualTo: userId)
          .orderBy('created_at', descending: true)
          .limit(1)
          .get();

      if (laporanQuery.docs.isNotEmpty) {
        // merge nama & foto user ke dalam map laporan
        final lap = Map<String, dynamic>.from(laporanQuery.docs.first.data());
        lap['name'] = userData['name'] ?? '';
        lap['profile_picture'] = userData['profile_picture'] ?? '';
        lap['userId'] = userId;

        final model = DetailLaporanModel.fromMap(
          lap,
          laporanQuery.docs.first.id,
        );
        list.add(model);
      } else {
        // dummy model untuk user tanpa laporan
        list.add(
          DetailLaporanModel(
            id: '',
            name: userData['name'] ?? 'Tidak diketahui',
            profilePicture: userData['profile_picture'] ?? '',
            vehicle: '',
            place: '',
            address: '',
            createdAt: DateTime.now(),
            weightTotal: 0,
            imagesBasah: [],
            imagesKering: [],
          ),
        );
      }
    }

    drivers.value = list;
  }
}
