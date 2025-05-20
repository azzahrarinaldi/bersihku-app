import 'package:flutter/material.dart';

class DropDownWilayahHistory extends StatelessWidget {
  final String selectedWilayah;
  final List<String> wilayahList;
  final ValueChanged<String> onChanged;

  const DropDownWilayahHistory({
    super.key,
    required this.selectedWilayah,
    required this.wilayahList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedWilayah.isEmpty ? null : selectedWilayah,
            hint: const Text(
              "Pilih Wilayah",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down, size: 20),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            dropdownColor: Colors.white,
            isExpanded: true,
            items: wilayahList.map((String wilayah) {
              return DropdownMenuItem<String>(
                value: wilayah,
                child: Text(
                  wilayah,
                  style: TextStyle(
                    fontWeight: wilayah == selectedWilayah
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
      ),
    );
  }
}
