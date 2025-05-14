import 'package:bersihku/const.dart';
import 'package:flutter/material.dart';
import 'history_menu.dart';

class HistoryCard extends StatelessWidget {
  final String documentId;
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
    required this.documentId,
    required this.name,
    required this.vehicle,
    required this.place,
    required this.address,
    required this.date,
    required this.time,
    required this.type,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset("assets/images/profile-person-history.png", width: 60),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name, 
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 15,
                          color: textColor
                        )
                      ),
                      const SizedBox(height: 5),
                      Text(
                        vehicle, 
                        style: TextStyle(
                          fontSize: 13, 
                          color: Colors.grey
                        )
                      ),
                    ],
                  ),
                ],
              ),
              HistoryMenu(documentId: documentId),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            place, 
            style: const TextStyle(
              fontSize: 15, 
              fontWeight: FontWeight.w600,
              color: textColor
            )
          ),
          const SizedBox(height: 9),
          Text(
            address, 
            style: const TextStyle(
              fontSize: 11
            )
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.w600
                )
              ), 
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.w600
                )
              )
            ]
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Text(
                type,
                style: TextStyle(
                fontSize: 13, 
                color: textColor,
                fontWeight: FontWeight.bold
              )
              ), 
              Text(
                "$weight Kg",
                style: TextStyle(
                fontSize: 13, 
                color: textColor, 
                fontWeight: FontWeight.bold
              )
              )
            ]
          ),
        ],
      ),
    );
  }
}