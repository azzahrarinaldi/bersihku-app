import 'package:bersihku/models/riwayat_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RiwayatController extends GetxController {
  var riwayatList = <RiwayatCardModel>[].obs;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchRiwayatData();
  }

  Future<void> fetchRiwayatData() async {
    if (user == null) return;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    final isAdmin = userDoc.data()?['role'] == 'admin';

    Query query = FirebaseFirestore.instance
        .collection('laporan_pengangkutan')
        .orderBy('created_at', descending: true)  // pake created_at
        .limit(3);

    if (!isAdmin) {
      query = query.where('userId', isEqualTo: user!.uid);
    }

    query.snapshots().listen((snap) {
      print("==> Got ${snap.docs.length} laporan");
      riwayatList.value = snap.docs
        .map((d) => RiwayatCardModel.fromMap(d.data() as Map<String, dynamic>))
        .toList();
    });
  }
}
