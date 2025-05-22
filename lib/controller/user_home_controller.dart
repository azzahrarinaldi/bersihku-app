import 'package:bersihku/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserHomeController extends GetxController {
  var user = Rx<UserModel?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      _firestore.collection('users').doc(uid).snapshots().listen((doc) {
        if (doc.data() != null) {
          user.value = UserModel.fromMap(uid, doc.data());
        } else {
          user.value = null;
        }
      });
    }
  }
}