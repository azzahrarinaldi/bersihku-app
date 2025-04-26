import 'package:flutter/material.dart';

class NotesDetailHistory extends StatefulWidget {
  const NotesDetailHistory({super.key});

  @override
  State<NotesDetailHistory> createState() => _NotesDetailHistoryState();
}

class _NotesDetailHistoryState extends State<NotesDetailHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Catatan',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Container(
          height: 150,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const TextField(
            expands: true,
            maxLines: null,
            minLines: null,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'tambahkan jika ada keperluan',
              contentPadding:
                  EdgeInsets.zero, alignLabelWithHint: true,
            ),
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
