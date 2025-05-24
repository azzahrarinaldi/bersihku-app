import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? suffixText;
  final double spacing;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool isPlate;

  const FieldWithLabel({
    super.key,
    required this.label,
    required this.controller,
    this.suffixText,
    this.spacing = 20,
    this.validator,
    this.readOnly = false,
    this.isPlate = false,
  });

  @override
  Widget build(BuildContext context) {
    // format untuk plat nomor
    final TextInputFormatter plateFormatter = TextInputFormatter.withFunction(
      (oldValue, newValue) {
        if (isPlate) {
          String cleaned =
              newValue.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

          // Contoh format sederhana: B 1234 XYZ
          String formatted = cleaned;
          if (cleaned.isNotEmpty && cleaned.length <= 9) {
            final buffer = StringBuffer();
            buffer.write(cleaned[0]);
            if (cleaned.length >= 2) {
              buffer.write(
                  ' ${cleaned.substring(1, cleaned.length.clamp(2, 5))}');
            }
            if (cleaned.length > 5) {
              buffer.write(' ${cleaned.substring(5)}');
            }
            formatted = buffer.toString();
          }

          return TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }
        return newValue;
      },
    );

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
                readOnly: readOnly,
                textCapitalization: isPlate
                    ? TextCapitalization.characters
                    : TextCapitalization.none,
                inputFormatters: isPlate ? [plateFormatter] : [],
                keyboardType: isPlate
                    ? TextInputType.text
                    : const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
