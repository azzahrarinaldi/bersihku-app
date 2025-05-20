import 'package:flutter/material.dart';

class NotesDetailHistory extends StatelessWidget {
  final String note;
  const NotesDetailHistory({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Catatan", 
          style: TextStyle(
            fontSize: 13, 
            fontWeight: FontWeight.bold, 
            color: Colors.black
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            note.isNotEmpty ? note : "Tidak ada catatan.", 
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}