// controllers/detail_data_supir_controller.dart

import 'package:bersihku/models/detail_data_supir_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailDataSupirController extends GetxController {
  final String supirId;
  DetailDataSupirController(this.supirId);

  var isLoading   = true.obs;
  var profile     = Rxn<DetailDataSupirModel>();
  var laporanList = <DetailDataSupirModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAll();
  }

  Future<void> _fetchAll() async {
    try {
      // 1) Fetch profil supir — tanpa plat_nomor di sini
      final uDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(supirId)
          .get();
      if (uDoc.exists) {
        final d = uDoc.data()!;
        profile.value = DetailDataSupirModel.fromMap({
          // Copy semua data user
          ...d,
          'profile_picture'  : d['profile_picture']   ?? '',
          'phone'            : d['phone']             ?? '',
          'name'             : d['name']              ?? '',
        });
      }

      // 2) Fetch laporan untuk supir ini, dan mapping termasuk plat_nomor
      final snap = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .where('userId', isEqualTo: supirId)
          .orderBy('created_at', descending: true)
          .get();

      final items = snap.docs.map((d) {
        final m = d.data();
        return DetailDataSupirModel.fromMap({
          ...m,
          'lokasi'           : m['lokasi'] ?? '',
          'alamat'           : m['alamat'] ?? '',
          'created_at'       : m['created_at'] ?? Timestamp.now(),
          'berat_keseluruhan': m['berat_keseluruhan'] ?? 0,
          'profile_picture'  : m['profile_picture'] ?? '',
          'phone'            : m['phone'] ?? '',
          'name'             : m['name'] ?? '',
          'plat_nomor'       : m['plat_nomor'] ?? '',   // <-- plat_nomor disini
        });
      }).toList();

      laporanList.assignAll(items);

      // 3) **Override** field `vehicle` di profile
      if (profile.value != null && items.isNotEmpty) {
        final p = profile.value!;
        profile.value = DetailDataSupirModel(
          place          : p.place,
          address        : p.address,
          createdAt      : p.createdAt,
          weightTotal    : p.weightTotal,
          profilePicture : p.profilePicture,
          phone          : p.phone,
          name           : p.name,
          vehicle        : items.first.vehicle,   // <-- ambil plat_nomor di sini
        );
      }

    } catch (e) {
      print("Error @DetailDataSupirController: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
