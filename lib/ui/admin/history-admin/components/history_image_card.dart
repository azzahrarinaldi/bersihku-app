import 'package:flutter/material.dart';

class HistoryImageCard extends StatelessWidget {
  final List<String> imagesBasah;
  final List<String> imagesKering;

  const HistoryImageCard({
    super.key,
    required this.imagesBasah,
    required this.imagesKering,
  });

  void showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        backgroundColor: Colors.black,
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context, String url) {
    return GestureDetector(
      onTap: () => showFullImage(context, url),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: 140,
          height: 100,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 40),
          ),
        ),
      ),
    );
  }

  Widget buildImageRow(BuildContext context, List<String> urls) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: urls.map((url) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: buildImage(context, url),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Foto Sampah Kering Sebelum & Sesudah Diangkat", 
          style: TextStyle(
            fontSize: 12, 
            fontWeight: FontWeight.w600, 
            color: Colors.black
          )
        ),
        const SizedBox(height: 10),
        buildImageRow(context, imagesKering),
        const SizedBox(height: 20),
        const Text(
          "Foto Sampah Basah Sebelum & Sesudah Diangkat", 
          style: TextStyle(
            fontSize: 12, 
            fontWeight: FontWeight.w600, 
            color: Colors.black
          )
        ),
        const SizedBox(height: 10),
        buildImageRow(context, imagesBasah),
      ],
    );
  }
}
