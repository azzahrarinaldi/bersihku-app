import 'package:flutter/material.dart';

class DropdownBulan extends StatelessWidget {
  final String selectedBulan;
  final List<String> bulanList;
  final ValueChanged<String> onChanged;

  const DropdownBulan({
    super.key,
    required this.selectedBulan,
    required this.bulanList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedBulan.isEmpty ? null : selectedBulan,
          hint: const Text(
            "Pilih Bulan", 
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
            )
          ),
          icon: const Icon(Icons.arrow_drop_down, size: 25),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          dropdownColor: Colors.white,
          items: bulanList.map((String wilayah) {
            return DropdownMenuItem<String>(
              value: wilayah,
              child: Text(
                wilayah,
                style: TextStyle(
                  fontWeight: wilayah == selectedBulan
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 14,
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
      ),
    );
  }
}