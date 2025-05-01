import 'package:bersihku/ui/user-front/profile-user/profile-user-screen/components/profile_option.dart';
import 'package:flutter/material.dart';

class ProfileScreenAdmin extends StatefulWidget {
  const ProfileScreenAdmin({super.key});

  @override
  State<ProfileScreenAdmin> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenAdmin> {
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
          child: Column(
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
                    const Text(
                      "Joko Priyanto",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "djokopri@gmail.com",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              const Expanded(
                child: ProfileOptions(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
