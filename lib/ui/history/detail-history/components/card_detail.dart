import 'package:bersihku/ui/history/detail-history/components/card_image.dart';
import 'package:bersihku/ui/history/detail-history/components/notes.dart';
import 'package:bersihku/ui/history/detail-history/components/total_wight.dart';
import 'package:flutter/material.dart';

class CardDetailHistory extends StatefulWidget {
  const CardDetailHistory({super.key});

  @override
  State<CardDetailHistory> createState() => _CardDetailHistoryState();
}

class _CardDetailHistoryState extends State<CardDetailHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                //profil dari si sopir
                Row(
                  children: [
                    Image.asset(
                      "assets/images/profile-person-history.png",
                      width: 60,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Joko Priyanto",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "B 1829 POP",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8), 

          //untuk penamaan alamat
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kemang Village Arpartement",
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5,),
              Text(
                "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
                style: TextStyle(fontSize: 11.7, color: Colors.black,),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rabu, 26 Februari 2025",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    "21.00-06.00",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              CardImage(),
              SizedBox(height: 10),
              TotalWight(),
              SizedBox(height: 20),
              NotesDetailHistory()
            ],
          ),
        ],
      ),
    );
  }
}
