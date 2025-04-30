import 'package:flutter/material.dart';

class DropdownWilayah extends StatelessWidget {
  final String selectedWilayah;
  final List<String> wilayahList;
  final ValueChanged<String> onChanged;

  const DropdownWilayah({
    super.key,
    required this.selectedWilayah,
    required this.wilayahList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedWilayah,
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        dropdownColor: Colors.white,
        items: wilayahList.map((String wilayah) {
          return DropdownMenuItem<String>(
            value: wilayah,
            child: Text(
              wilayah,
              style: TextStyle(
                fontWeight: wilayah == selectedWilayah
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