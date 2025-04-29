import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Constraints extends StatelessWidget {
  const Constraints({super.key});

  static const String adminPhoneNumber = '6285694787246';

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/6285694787246");

    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch WhatsApp: $whatsappUrl");
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/constrains-trash.png",
            height: screenWidth * 0.25,
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ada Kendala Pengangkutan?",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Text(
                  "Laporkan Jika Mengalami Kendala Pengangkutan",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF646464)),
                ),
                ElevatedButton(
                  onPressed: _launchWhatsApp,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.55, screenWidth * 0.075),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    foregroundColor: const Color(0xFF4EBAE5),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(
                        color: Color(0xFF4EBAE5),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    "Beri Tahu admin di Sini!",
                    style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold),
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
