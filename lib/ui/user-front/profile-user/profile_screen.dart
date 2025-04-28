import 'package:bersihku/ui/user-front/profile-user/components/profile_option.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>?> getUserData() async {
    if (user == null) return null;

    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid) // tambahin tanda seru buat kasih tau compiler bahwa user gak null
        .get();

    return doc.data();
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
          child: FutureBuilder<Map<String, dynamic>?>(
            future: getUserData(),
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
                          child: Image.asset(
                            "assets/images/profile-person-history.png",
                            width: screenWidth * 0.2,
                            fit: BoxFit.contain,
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
