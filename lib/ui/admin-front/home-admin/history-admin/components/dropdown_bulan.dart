import 'package:flutter/material.dart';

class DropdownBulan extends StatelessWidget {
  final String selectedBulan;
  final List<String> BulanList;
  final ValueChanged<String> onChanged;

  const DropdownBulan({
    super.key,
    required this.selectedBulan,
    required this.BulanList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedBulan,
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        dropdownColor: Colors.white,
        items: BulanList.map((String wilayah) {
          return DropdownMenuItem<String>(
            value: wilayah,
            child: Text(
              wilayah,
              style: TextStyle(
                fontWeight: wilayah == selectedBulan
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }
}