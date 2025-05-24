import 'package:bersihku/models/detail_history_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryDetailController extends GetxController {
  final String documentId;  // ID dokumennya laporan yang mau ditampilkan

  HistoryDetailController(this.documentId);

  RxBool isLoading = true.obs; // Flag loading, biar tau kapan data masih diproses
  Rxn<HistoryDetailModel> detail = Rxn<HistoryDetailModel>();  // Model nullable buat nampung data laporan

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null);  // Daftarin format tanggal Bahasa Indonesia
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    isLoading.value = true; // Set loading = true sebelum mulai fetch
    try {
      // 1) Ambil user yang lagi login
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        detail.value = null; // Kalau belum login, langsung set null
        return;
      }

      // 2) Siapin referensi ke Firestore:
      //    - laporan_pengangkutan/documentId
      //    - users/user.uid
      final laporanRef = FirebaseFirestore.instance
        .collection('laporan_pengangkutan')
        .doc(documentId);
      final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

      // 3) Fetch sekali aja (bukan stream)
      final laporanSnapshot = await laporanRef.get();
      final userSnapshot = await userRef.get();

      // 4) Kalau salah satu gak ada, set detail jadi null
      if (!laporanSnapshot.exists || !userSnapshot.exists) {
        detail.value = null;
      } else {
        // 5) Bikin model dari data Firestore + nama user
        detail.value = HistoryDetailModel.fromFirestore(
          laporanSnapshot,
          userSnapshot.get('name') ?? 'No Name',
        );
      }
    } catch (e) {
      // 6) Kalau error apa pun, jangan crash—set detail null aja
      detail.value = null;
    } finally {
      // 7) Selesai proses, loading = false supaya UI bisa hide indikator
      isLoading.value = false;
    }
  }
}
