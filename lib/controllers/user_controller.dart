import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  var userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
  }

  void fetchUserName() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      userName.value = userDoc['name']; // Sesuaikan field-nya
    }
  }
}
