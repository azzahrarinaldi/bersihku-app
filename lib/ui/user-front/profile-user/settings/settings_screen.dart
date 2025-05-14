import 'dart:io'; 
import 'package:bersihku/ui/user-front/profile-user/settings/components/form_settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _getProfileImage();  // Mengambil gambar profil saat halaman dimuat
  }

  // Fungsi untuk mengambil gambar profil dari Firestore
  Future<void> _getProfileImage() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      String? profileImageUrl = doc.data()?['profile_picture'];

      if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
        setState(() {
          _profileImageUrl = profileImageUrl;
        });
      } else {
        // Jika tidak ada gambar, set gambar default
        _profileImageUrl = "assets/images/profile-person-history.png";
      }
    } catch (e) {
      print('Error fetching profile image: $e');
      _profileImageUrl = "assets/images/profile-person-history.png"; // Default
    }
  }

  // Fungsi untuk mengunggah gambar ke Firebase Storage dan memperbarui Firestore
  Future<void> _uploadImageToFirebase() async {
    if (_imageFile == null) return;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${FirebaseAuth.instance.currentUser?.uid}.jpg');

      final uploadTask = storageRef.putFile(_imageFile!);
      await uploadTask.whenComplete(() async {
        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update({'profile_picture': imageUrl});

        // Perbarui gambar profil setelah upload
        setState(() {
          _profileImageUrl = imageUrl;
        });
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  // Fungsi untuk menampilkan opsi ambil gambar
  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Ambil dari Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                    _uploadImageToFirebase();  // Upload gambar ke Firebase
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                    _uploadImageToFirebase();  // Upload gambar ke Firebase
                  }
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
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 15),
            child: Column(
              children: [
                // Menampilkan gambar profil
                _profileImageUrl == null
                    ? Image.asset(
                        "assets/images/profile-person-history.png",
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          _profileImageUrl!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(height: 10),
                InkWell(
                  onTap: _showImageSourceActionSheet,
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
      ),
    );
  }
}
