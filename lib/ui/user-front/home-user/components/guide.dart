import 'package:bersihku/ui/user-front/guide/guide_screen.dart';
import 'package:flutter/material.dart';

class Guide extends StatelessWidget {
  const Guide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pelajari cara menggunakan aplikasi ini untuk melaporkan dan memantau pengangkutan sampah dengan mudah!",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 7),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size(10, 32),
                      backgroundColor: Color(0xFF4EBAE5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                 HelpGuideScreen()), // ganti dengan screen tujuan kamu
                        );
                      },
                      child: const Text(
                        "Panduan Penggunaan Aplikasi",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                           ),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Image.asset(
            "assets/images/guide.png",
            width: 90,
            height: 105,
          ),
        ],
      ),
    );
  }
}
