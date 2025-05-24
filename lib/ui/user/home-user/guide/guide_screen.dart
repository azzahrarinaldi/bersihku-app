import 'package:bersihku/controller/guide_controller.dart';
import 'package:bersihku/ui/user/home-user/guide/components/instruction_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpGuideScreen extends StatelessWidget {
  HelpGuideScreen({super.key});

  final GuideController controller = Get.put(GuideController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/orange-pattern.png"),
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Panduan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Image.asset("assets/images/guide-image.png", width: 100),
                ),
                const SizedBox(height: 29),
                Expanded(
                  child: SingleChildScrollView(
                    child: InstructionCards(instructions: controller.instructions),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}