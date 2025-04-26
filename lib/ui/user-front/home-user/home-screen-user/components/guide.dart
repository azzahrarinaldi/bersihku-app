import 'package:bersihku/ui/user-front/home-user/guide/guide_screen.dart';
import 'package:flutter/material.dart';

class Guide extends StatelessWidget {
  const Guide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Expanded untuk teks dan button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mengatur ukuran font lebih besar dan menggunakan overflow
                Text(
                  "Pelajari cara menggunakan aplikasi ini untuk melaporkan dan memantau pengangkutan sampah dengan mudah!",
                  style: TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 4, 
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpGuideScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(0xFF4EBAE5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    "Panduan Penggunaan Aplikasi",
                    style: TextStyle(
                      fontSize: 11, 
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 1),
          // Gambar di kanan
          Image.asset(
            "assets/images/guide(2).png",
            width: 90,
            height: 105,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
