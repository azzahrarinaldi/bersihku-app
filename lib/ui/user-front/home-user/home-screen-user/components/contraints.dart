import 'package:flutter/material.dart';

class Constraints extends StatelessWidget {
  const Constraints({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Biar image sejajar tengah
        children: [
          Image.asset(
            "assets/images/constrains-trash.png",
            height: 100,
          ),
          SizedBox(width: 16),
          Expanded( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Ada Kendala Pengangkutan?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Laporkan Jika Mengalami Kendala Pengangkutan",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF646464),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                   style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 30),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Color(0xFF4EBAE5),
                    shadowColor: Colors.transparent,
                    surfaceTintColor:
                        Colors.transparent, 
                    splashFactory:
                        NoSplash.splashFactory, 
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
                      fontSize: 11.31,
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
