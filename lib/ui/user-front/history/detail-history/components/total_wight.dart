import 'package:flutter/material.dart';

class TotalWight extends StatefulWidget {
  const TotalWight({super.key});

  @override
  State<TotalWight> createState() => _TotalWightState();
}

class _TotalWightState extends State<TotalWight> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Pengangkutan sampah",
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          "1.648 kg",
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}