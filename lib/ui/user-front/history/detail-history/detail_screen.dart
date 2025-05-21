import 'package:bersihku/ui/user-front/history/detail-history/components/card_detail.dart';
import 'package:flutter/material.dart';

class DetailScreenHistory extends StatelessWidget {
  final String documentId;
  const DetailScreenHistory({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios, 
                        color: Colors.white
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Detail Riwayat',
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20), 
                    child: CardDetailHistory(documentId: documentId),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
