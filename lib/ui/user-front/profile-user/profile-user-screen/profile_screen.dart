import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bersihku/ui/user-front/profile-user/profile-user-screen/components/profile_option.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String? profileImageUrl;

  // Ambil foto profil dari Firestore (field 'profile_picture')
  Future<void> getProfileImage(String? profilePictureUrl) async {
    if (profilePictureUrl != null && profilePictureUrl.isNotEmpty) {
      setState(() {
        profileImageUrl = profilePictureUrl;
      });
    } else {
      try {
        String defaultProfileImageUrl = await FirebaseStorage.instance
            .ref('profile_images/default_profile.jpg')
            .getDownloadURL();
        setState(() {
          profileImageUrl = defaultProfileImageUrl;
        });
      } catch (e) {
        print('Gagal mengambil gambar default: $e');
      }
    }
  }

  Stream<Map<String, dynamic>?> getUserStream() {
    if (user == null) {
      return const Stream.empty();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }

  @override
  void initState() {
    super.initState();
    // Inisialisasi gambar default untuk sementara sebelum stream jalan
    getProfileImage(null);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF4EBAE5),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blue-pettern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: getUserStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("User data not found"));
              }

              final data = snapshot.data!;
              final name = data['name'] ?? 'No Name';
              final email = data['email'] ?? 'No Email';
              final profilePictureUrl = data['profile_picture'];

              // Update foto setiap kali datanya berubah
              getProfileImage(profilePictureUrl);

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.topCenter,
                          child: profileImageUrl == null
                              ? Image.asset(
                                  "assets/images/profile-person-history.png",
                                  width: screenWidth * 0.2,
                                  fit: BoxFit.contain,
                                )
                              : CircleAvatar(
                                  radius: screenWidth * 0.1,
                                  backgroundImage: NetworkImage(profileImageUrl!),
                                ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Expanded(
                    child: ProfileOptions(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
