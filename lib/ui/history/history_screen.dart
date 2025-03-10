import 'package:bersihku/ui/history/components/history_card.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4EBAE5),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blue-pettern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 20),
              child: Row(
                children: [
                  Text(
                    "Riwayat Pengangkutan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: HistoryCard(
                name: "Joko Priyanto",
                vehicle: "B 1829 POP",
                place: 'Kemang Village Apartment',
                address: "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
                date: "Rabu, 26 Februari 2025",
                time: "21.00 - 06.00",
                type: "Pengangkutan Sampah",
                weight: "1.648",
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 3, 
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          HistoryCard(
                            name: "Joko Priyanto",
                            vehicle: "B 1829 POP",
                            place: 'Kemang Village Apartment',
                            address:
                                "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
                            date: "Rabu, 26 Februari 2025",
                            time: "21.00 - 06.00",
                            type: "Pengangkutan Sampah",
                            weight: "1.648",
                          ),
                          SizedBox(height: 15),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
