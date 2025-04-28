import 'package:bersihku/ui/user-front/home-user/input-form/input_form_screen.dart';
import 'package:flutter/material.dart';

class Constraints extends StatelessWidget {
  const Constraints({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width; 

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.05), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, 
        children: [
          Image.asset(
            "assets/images/constrains-trash.png",
            height: screenWidth *
                0.25, // Menyesuaikan ukuran gambar dengan lebar layar
          ),
          SizedBox(
              width: screenWidth * 0.04), // Menyesuaikan jarak antar elemen
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Ada Kendala Pengangkutan?",
                  style: TextStyle(
                    fontSize: 12, // Ukuran font responsif
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Laporkan Jika Mengalami Kendala Pengangkutan",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF646464),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                   
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.55,
                        screenWidth * 0.075), // Ukuran responsif tombol
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
                    "Beri Tahu admin di Sini!",
                    style: TextStyle(
                      fontSize: screenWidth * 0.03, // Ukuran font responsif
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
