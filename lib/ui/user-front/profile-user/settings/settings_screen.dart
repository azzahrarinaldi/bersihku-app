import 'package:bersihku/ui/user-front/profile-user/settings/components/form_settings.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        title: const Text(
          "Pengaturan Akun",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06, 
              vertical: 20,
            ),
            child: Column(
              children: [
                // Bagian gambar dan teks tetap di tengah
                Column(
                  children: [
                    Image.asset(
                      "assets/images/profile-person-history.png",
                      height: 100, 
                      fit: BoxFit.cover, 
                    ),
                    SizedBox(height: 10), 
                    InkWell(
                      onTap: () {
                        // Aksi saat teks ditekan
                        print("Edit Foto Pressed");
                      },
                      child: Text(
                        "Edit Foto",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline, 
                          decorationColor: Colors.blueAccent,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Jarak antara gambar dan form
          
                // FormSettingsScreen tidak di tengah
                FormSettingsScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
