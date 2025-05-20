import 'package:bersihku/controller/profile_user_controller.dart';
import 'package:bersihku/ui/user-front/profile-user/profile-user-screen/components/profile_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileUserController());

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
          child: Obx(() {
            final userData = controller.user.value;
            final profileImage = controller.profileImageUrl.value;

            if (userData == null) {
              return const Center(child: CircularProgressIndicator());
            }

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
                        child: CircleAvatar(
                          radius: screenWidth * 0.1,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              (profileImage != null && profileImage.isNotEmpty)
                                  ? NetworkImage(profileImage)
                                  : null,
                          child: (profileImage == null || profileImage.isEmpty)
                              ? Icon(Icons.person,
                                  size: screenWidth * 0.1,
                                  color: Colors.grey[600])
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userData.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userData.email!,
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
          }),
        ),
      ),
    );
  }
}
