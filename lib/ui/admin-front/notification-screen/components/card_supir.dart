import 'package:flutter/material.dart';
import 'package:bersihku/const.dart';

class CardSupir extends StatelessWidget {
  final Map<String, String> item;
  final Size size;

  const CardSupir({super.key, required this.item, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profil
          Row(
            children: [
              CircleAvatar(
                radius: size.width * 0.07,
                backgroundImage: AssetImage(item['foto']!),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            item['nama']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 3,
                          child: Text(
                            item['alamat']!,
                            style: TextStyle(
                              color: textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.025,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Sopir / (${item['plat']})",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: size.width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          // Catatan
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Masukkan catatan...',
                hintStyle:
                    TextStyle(fontSize: 13, color: Colors.grey),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 16),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
                suffixIconConstraints:
                    const BoxConstraints(maxHeight: 36, maxWidth: 36),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: InputBorder.none,
              ),
            ),
          ),

          SizedBox(height: 13),

          const Text(
            "Pengangkutan terakhir",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Icon(Icons.fiber_manual_record,
                      size: 14, color: Colors.lightBlue),
                  Container(
                    width: 2,
                    height: 30,
                    color: Colors.lightBlue,
                  ),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['tanggal']!),
                    Text(item['lokasi']!),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
