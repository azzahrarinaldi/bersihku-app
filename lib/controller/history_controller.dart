import 'package:bersihku/models/history_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryController extends GetxController {
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;
  RxString userName = 'Pengguna'.obs;
  RxString userImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null);
    fetchUserData();
    fetchHistory();
  }

  void fetchUserData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data();
      if (data != null) {
        userName.value = data['name'] ?? 'Pengguna';
        userImage.value = data['profile_picture'] ?? '';

        // Update ulang history biar name-nya ikut berubah
        fetchHistory();
      }
    });
  }

  void fetchHistory() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    FirebaseFirestore.instance
        .collection('laporan_pengangkutan')
        .where('userId', isEqualTo: uid)
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snapshot) {
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        final createdAt = (data['created_at'] as Timestamp).toDate();
        return HistoryModel(
          documentId: doc.id,
          name: userName.value,
          vehicle: data['plat_nomor'] ?? '',
          place: data['lokasi'] ?? '',
          address: data['alamat'] ?? '',
          date: formatTanggal(createdAt),
          time: formatWaktu(createdAt),
          type: 'Pengangkutan Sampah',
          weight: data['berat_keseluruhan']?.toString() ?? '0',
          profileImage: data['profile_image'] ?? '',
        );
      }).toList();
      historyList.assignAll(list);
    });
  }

  String formatTanggal(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
  }

  String formatWaktu(DateTime date) {
    return '${DateFormat('HH:mm', 'id_ID').format(date)} WIB';
  }
}