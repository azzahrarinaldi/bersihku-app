import 'package:bersihku/ui/history/detail-history/components/card_detail.dart';
import 'package:flutter/material.dart';

class DetailScreenHistory extends StatefulWidget {
  const DetailScreenHistory({super.key});

  @override
  State<DetailScreenHistory> createState() => _DetailScreenHistoryState();
}

class _DetailScreenHistoryState extends State<DetailScreenHistory> {
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
          child: Padding(
              padding:EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, 
                  vertical: 20, 
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Detail Supir",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), 
                  CardDetailHistory(),
                ],
              ))),
    );
  }
}
