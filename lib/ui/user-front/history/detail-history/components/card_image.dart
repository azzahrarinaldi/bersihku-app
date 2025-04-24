import 'package:flutter/material.dart';

class CardImage extends StatefulWidget {
  const CardImage({super.key});

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        //untuk dokumentasi sampah kering
        Text(
          "Foto Sampah Kering Sebelum & Sesudah Diangkat",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        SizedBox(height: 10),
        
        //image dari dokumentasi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/sampah-kering-sebelum-diangkat.png",
              width: 150,
            ),
            Image.asset(
              "assets/images/sampah-kering-sebelum-diangkat.png",
              width: 150,
            ),
          ],
        ),
        SizedBox(height: 20),

        
        //untuk dokumentasi sampah basah
        Text(
          "Foto Sampah Kering Sebelum & Sesudah Diangkat",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        SizedBox(height: 10),
        //image dari dokumentasi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/sampah-kering-sebelum-diangkat.png",
              width: 150,
            ),
            Image.asset(
              "assets/images/sampah-kering-sebelum-diangkat.png",
              width: 150,
            ),
          ],
        )
      ],
    );
  }
}