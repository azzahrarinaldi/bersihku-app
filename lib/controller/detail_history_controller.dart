import 'package:bersihku/models/detail_history_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryDetailController extends GetxController {
  final String documentId;

  HistoryDetailController(this.documentId);

  RxBool isLoading = true.obs;
  Rxn<HistoryDetailModel> detail = Rxn<HistoryDetailModel>();

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null);
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    isLoading.value = true;
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        detail.value = null;
        isLoading.value = false;
        return;
      }

      final laporanRef = FirebaseFirestore.instance.collection('laporan_pengangkutan').doc(documentId);
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      final laporanSnapshot = await laporanRef.get();
      final userSnapshot = await userRef.get();

      if (!laporanSnapshot.exists || !userSnapshot.exists) {
        detail.value = null;
      } else {
        detail.value = HistoryDetailModel.fromFirestore(laporanSnapshot, userSnapshot.get('name') ?? 'No Name');
      }
    } catch (e) {
      detail.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}