import 'package:bersihku/models/user_model.dart';
import 'package:bersihku/ui/auth/login/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProfileUserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  var user = Rxn<UserModel>();
  var profileImageUrl = RxnString();

  @override
  void onInit() {
    super.onInit();

    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    _firestore
        .collection('users')
        .doc(currentUser.uid)
        .snapshots()
        .listen((doc) async {
      if (doc.exists) {
        final data = UserModel.fromMap(doc.id, doc.data()!);
        user.value = data;

        // Cek dan ambil gambar profile
        profileImageUrl.value =
            await _getProfileImageUrl(data.profilePicture);
      }
    });
  }

  // Ambil foto profil dari Firestore (field 'profile_picture')
  Future<String> _getProfileImageUrl(String? profilePictureUrl) async {
    if (profilePictureUrl != null && profilePictureUrl.isNotEmpty) {
      return profilePictureUrl;
    } else {
      try {
        return await _storage
            .ref('profile_images/default_profile.jpg')
            .getDownloadURL();
      } catch (e) {
        print('Error loading default profile image: $e');
        return '';
      }
    }
  }

  // Logout
  Future<void> logoutAndRedirect() async {
  await _auth.signOut();
  Get.offAll(() => const LoginScreen());
}
}