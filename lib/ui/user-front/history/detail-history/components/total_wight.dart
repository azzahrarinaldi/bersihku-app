import 'package:bersihku/const.dart';
import 'package:flutter/material.dart';

class TotalWight extends StatelessWidget {
  final String total;
  const TotalWight({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Pengangkutan sampah", 
          style: TextStyle(
            fontSize: 13, 
            color: textColor, 
            fontWeight: FontWeight.bold
          )
        ),
        Text(
          "$total kg", 
          style: TextStyle(
            fontSize: 13, 
            color: textColor, 
            fontWeight: FontWeight.bold
          )
        ),
      ],
    );
  }
}
