import 'package:flutter/material.dart';

class FieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? suffixText;
  final double spacing;
  final String? Function(String?)? validator; 

  const FieldWithLabel({
    Key? key,
    required this.label,
    required this.controller,
    this.suffixText,
    this.spacing = 20,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( 
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              child: TextFormField(
                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                ),
              ),
            ),
            if (suffixText != null) ...[
              const SizedBox(width: 10),
              Text(
                suffixText!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )
            ]
          ],
        ),
      ],
    );
  }
}
