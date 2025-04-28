import 'package:flutter/material.dart';
import 'history_menu.dart'; // Import file menu

class HistoryCard extends StatelessWidget {
  final String name;
  final String vehicle;
  final String place;
  final String address;
  final String date;
  final String time;
  final String type;
  final String weight;

  const HistoryCard({
    super.key,
    required this.name,
    required this.vehicle,
    required this.address,
    required this.date,
    required this.time,
    required this.type,
    required this.weight,
    required this.place,
  });

  void _handleMenuSelection(String value) {
    if (value == 'edit') {
      print("Edit dipilih");
    } else if (value == 'detail') {
      print("Detail dipilih");
    }
  }

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
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          vehicle,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                HistoryMenu(onSelected: _handleMenuSelection),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            place,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 9),
          Text(address, style: TextStyle(fontSize: 11, color: Colors.black)),
          SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: TextStyle(fontSize: 11, color: Colors.black)),
              Text(time, style: TextStyle(fontSize: 11, color: Colors.black)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$weight Kg",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
