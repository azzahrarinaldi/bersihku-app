import 'package:bersihku/ui/user-front/home-user/input-form/input_form_screen.dart';
import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
   double screenWidth = MediaQuery.of(context).size.width; 

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.05), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Image.asset(
            "assets/images/report-trash.png",
            height: screenWidth * 0.25, 
          ),
          SizedBox(width: screenWidth * 0.04), 
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                "Buat Laporan Pengangkutan?",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Buat Laporan untuk hari ini!",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF646464),
                  ),
                ),
                SizedBox(height: 5), 
                ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            InputFormScreen() // Ganti dengan screen yang ingin dituju
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.55, screenWidth * 0.075), 
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Color(0xFF4EBAE5),
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent, 
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(
                        color: Color(0xFF4EBAE5),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    "Buat Laporan",
                    style: TextStyle(
                      fontSize: screenWidth * 0.03, 
                      fontWeight: FontWeight.bold,
                    ),
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
