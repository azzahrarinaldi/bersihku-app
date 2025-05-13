import 'package:get/get.dart';
import '../models/data_supir_profile_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Aktifkan kalau pakai Firestore

class DataSupirProfileController extends GetxController {
  var supirList = <DataSupirProfileModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
    // fetchSupirFromFirestore(); // kalau udah setup Firebase
  }

  // Dummy data dulu
  void loadDummyData() {
    supirList.value = [
      DataSupirProfileModel(
        image: 'assets/images/profile-person-history.png',
        name: 'Budi Setiawan',
        vehicle: 'B 1212 GGH',
        userWhatsApp: '08112223344',
      ),
    ];
  }

  // ini di pakai nanti jika sudah memakai Firestore
  // void fetchSupirFromFirestore() async {
  //   final snapshot = await FirebaseFirestore.instance.collection('supir_profiles').get();
  //   supirList.value = snapshot.docs.map((doc) {
  //     return DataSupirProfileModel.fromMap(doc.data());
  //   }).toList();
  // }

  void addSupir(DataSupirProfileModel supir) {
    supirList.add(supir);
    // FirebaseFirestore.instance.collection('supir_profiles').add(supir.toMap());
  }

  void removeSupir(int index) {
    supirList.removeAt(index);
    // Untuk hapus dari Firebase, kamu perlu simpan ID dokumen juga
  }
}
