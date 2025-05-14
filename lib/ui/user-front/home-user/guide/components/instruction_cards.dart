import 'package:flutter/material.dart';

class InstructionCards extends StatelessWidget {
  final List<Map<String, String>> instructions;

  const InstructionCards({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: instructions.map((instruction) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                instruction["text"]!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Image.asset(
                  instruction["imagePath"]!,
                  width: double.tryParse(
                      instruction["width"] ?? "100"), 
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
