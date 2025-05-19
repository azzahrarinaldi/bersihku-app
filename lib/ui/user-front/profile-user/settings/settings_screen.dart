import 'package:bersihku/controller/user_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bersihku/ui/user-front/profile-user/settings/components/form_settings.dart';

class UserSettingsScreen extends StatelessWidget {
  UserSettingsScreen({super.key});

  final UserSettingController controller = Get.put(UserSettingController());

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Ambil dari Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
              leading: Icon(Icons.delete, color: Colors.red,),
              title: Text('Hapus Foto', style: TextStyle(color: Colors.red),),
              onTap: () async {
                Navigator.pop(context);
                await controller.deleteProfileImage();
              },
            ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        title: const Text(
          "Pengaturan Akun",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06, vertical: 15),
          child: Column(
            children: [
              Obx(() {
                final profileImageUrl = controller.profileImageUrl.value;

                return profileImageUrl.isEmpty
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      )
                    : profileImageUrl.startsWith('http')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              profileImageUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              profileImageUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          );
              }),
              SizedBox(height: 10),
              InkWell(
                onTap: () => _showImagePickerOptions(context),
                child: Text(
                  "Edit Foto",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blueAccent,
                    decorationThickness: 1,
                  ),
                ),
              ),
              SizedBox(height: 10),
              FormSettingsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
