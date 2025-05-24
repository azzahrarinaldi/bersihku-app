import 'package:bersihku/models/history_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryController extends GetxController {
  // List yang akan menyimpan semua data riwayat (history)
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;

  // Menyimpan nama user (ditampilkan di UI)
  RxString userName = 'Pengguna'.obs;

  // Menyimpan URL foto profil user
  RxString userImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null); // Inisialisasi format tanggal Indonesia
    fetchUserData(); // Ambil data user
    fetchHistory(); // Ambil history awal
  }

  // Fungsi untuk ambil data user saat ini dari Firestore
  void fetchUserData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return; // Jika belum login, keluar dari fungsi

    // Dengarkan perubahan data user secara real-time
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data();
      if (data != null) {
        userName.value = data['name'] ?? 'Pengguna';
        userImage.value = data['profile_picture'] ?? '';

        // Ambil ulang riwayat supaya nama ikut ter-update
        fetchHistory();
      }
    });
  }

  // Fungsi untuk ambil data laporan pengangkutan berdasarkan user yang login
  void fetchHistory() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    FirebaseFirestore.instance
        .collection('laporan_pengangkutan')
        .where('userId', isEqualTo: uid) // Filter hanya laporan milik user tersebut
        .orderBy('created_at', descending: true) // Urutkan dari yang terbaru
        .snapshots()
        .listen((snapshot) {
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        final createdAt = (data['created_at'] as Timestamp).toDate();

        return HistoryModel(
          documentId: doc.id,
          name: userName.value, // Nama user diambil dari variabel RxString
          vehicle: data['plat_nomor'] ?? '',
          place: data['lokasi'] ?? '',
          address: data['alamat'] ?? '',
          date: formatTanggal(createdAt), // Format tanggal ke bahasa Indonesia
          time: formatWaktu(createdAt), // Format jam ke WIB
          type: 'Pengangkutan Sampah', // Tipe default
          weight: data['berat_keseluruhan']?.toString() ?? '0',
          profileImage: data['profile_image'] ?? '',
        );
      }).toList();

      // Masukkan hasil mapping ke observable list
      historyList.assignAll(list);
    });
  }

  // Format tanggal: contoh "Senin, 20 Mei 2024"
  String formatTanggal(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
  }

  // Format waktu: contoh "14:30 WIB"
  String formatWaktu(DateTime date) {
    return '${DateFormat('HH:mm', 'id_ID').format(date)} WIB';
  }
}
