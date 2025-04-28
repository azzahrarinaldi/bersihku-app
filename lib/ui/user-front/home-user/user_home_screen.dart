import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bersihku/ui/user-front/history/history%20screen/history_screen.dart';
import 'package:bersihku/ui/user-front/profile-user/profile_screen.dart';
import 'package:bersihku/ui/user-front/home-user/components/guide.dart';
import 'package:bersihku/ui/user-front/home-user/components/report.dart';
import 'package:bersihku/ui/user-front/home-user/components/contraints.dart';
import 'package:bersihku/ui/user-front/home-user/components/bottom_navbar.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0;
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        final data = doc.data();
        if (data != null && data.containsKey('name')) {
          setState(() {
            userName = data['name'];
          });
        }
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Widget _buildHomeContent() {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/blue-pettern.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Greeting
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hai, $userName 👋🏻",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Siap menjemput sampah hari ini?",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  // Notification Icon
                  Image.asset(
                    "assets/icons/notification.png",
                    width: 40,
                    height: 40,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Guide, Report, Constraints
              const Guide(),
              const SizedBox(height: 20),
              const Text(
                "Drop In",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Report(),
              const SizedBox(height: 20),
              const Constraints(),
            ],
          ),
        ),
      ),
    );
  }

  final List<Widget> _widgetOptions = [];

  @override
  Widget build(BuildContext context) {
    _widgetOptions.clear();
    _widgetOptions.add(_buildHomeContent());
    _widgetOptions.add(const HistoryScreen());
    _widgetOptions.add(const ProfileScreen());

    return Scaffold(
      backgroundColor: const Color(0xFF4EBAE5),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
