import 'package:flutter/material.dart';

class LocationDropdown extends StatefulWidget {
  final Function(String? lokasi, String? alamat) onChanged;
  final String? Function(String?)? validator;

  const LocationDropdown({
    super.key,
    required this.onChanged,
    this.validator,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LocationDropdownState createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {
  final Map<String, String> locationMap = {
    "Margo City": "Jl. Margonda Raya No.358, Kemiri Muka, Kecamatan Beji, Kota Depok, Jawa Barat 16423",
    "Kuningan City Mall": "Jl. Prof. DR. Satrio No.Kav. 18, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12940",
    "Mall Artha Gading": "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading, Jkt Utara, Daerah Khusus Ibukota Jakarta 14240",
  };

  String? selectedLocation;
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
          ),
          items: locationMap.keys.map((lokasi) {
            return DropdownMenuItem(
              value: lokasi,
              child: Text(lokasi),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedLocation = value;
              selectedAddress = locationMap[value];
            });
            // Mengirim data lokasi & alamat ke controller
            widget.onChanged(value, selectedAddress);
          },
          hint: const Text("Pilih Mall"),
          validator: widget.validator,
        ),
        if (selectedAddress != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Alamat: $selectedAddress",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
      ],
    );
  }
}
