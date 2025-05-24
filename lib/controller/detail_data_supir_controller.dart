import 'package:bersihku/models/detail_data_supir_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailDataSupirController extends GetxController {
  final String supirId;
  DetailDataSupirController(this.supirId);

  // 1) isLoading: untuk menandai saat data sedang diambil
  var isLoading   = true.obs;

  // 2) profile: Reactive Nullable, bisa null atau DetailDataSupirModel
  var profile     = Rxn<DetailDataSupirModel>();

  // 3) laporanList: list reactive untuk menampung laporan supir
  var laporanList = <DetailDataSupirModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAll(); // panggil data fetching pas init
  }

  Future<void> _fetchAll() async {
    try {
      // === 1) Fetch data profil supir dari koleksi `users` ===
      final uDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(supirId)
          .get();
      if (uDoc.exists) {
        final d = uDoc.data()!;
        profile.value = DetailDataSupirModel.fromMap({
          // Merge data user ke map baru
          ...d,
          'profile_picture'  : d['profile_picture'] ?? '', // pastikan ada key
          'phone'            : d['phone']           ?? '',
          'name'             : d['name']            ?? '',
        });
      }

      // === 2) Fetch semua laporan milik supir ini ===
      final snap = await FirebaseFirestore.instance
          .collection('laporan_pengangkutan')
          .where('userId', isEqualTo: supirId) // filter berdasarkan supirId
          .orderBy('created_at', descending: true) // urutkan terbaru dulu
          .get();

      // Mapping tiap dokumen jadi model, pastikan semua field tersedia
      final items = snap.docs.map((d) {
        final m = d.data(); // Map<String, dynamic>
        return DetailDataSupirModel.fromMap({
          ...m,
          'lokasi'           : m['lokasi']            ?? '',
          'alamat'           : m['alamat']            ?? '',
          'created_at'       : m['created_at']        ?? Timestamp.now(),
          'berat_keseluruhan': m['berat_keseluruhan'] ?? 0,
          'profile_picture'  : m['profile_picture']   ?? '',
          'phone'            : m['phone']             ?? '',
          'name'             : m['name']              ?? '',
          'plat_nomor'       : m['plat_nomor']        ?? '',
        });
      }).toList();

      // assignAll: ganti seluruh isi laporanList dengan items baru
      laporanList.assignAll(items);

      // === 3) Override field vehicle di profile ===
      // Misalnya model supir punya properti `vehicle` untuk plat_nomor
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
          vehicle        : items.first.vehicle,
        );
      }

    } finally {
      // Set loading false, UI yang observe isLoading akan hide loading indicator
      isLoading.value = false;
    }
  }
}
