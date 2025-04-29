import 'package:flutter/material.dart';

class LocationDropdown extends StatelessWidget {
  final Function(String?) onChanged;
  final String? Function(String?)? validator; 

  const LocationDropdown({
    super.key,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
      ),
      items: const [
        DropdownMenuItem(
          child: Text("Margo City"),
          value: "moi",
        ),
        DropdownMenuItem(
          child: Text("Kuningan City"),
          value: "kuningan",
        ),
        DropdownMenuItem(
          child: Text("Mall Artha Gading"),
          value: "mag",
        ),
      ],
      onChanged: onChanged,
      hint: const Text("Pilih"),
      validator: validator, // Menambahkan validator
    );
  }
}
