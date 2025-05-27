import 'dart:typed_data';
import 'package:image/image.dart' as img;

Future<Map<String, dynamic>> processImageOptimized({
  required List<int> raw,
  required String timestamp,
  required String petugas,
  required String lokasi,
  required String path,
}) async {
  img.Image? image = img.decodeImage(Uint8List.fromList(raw));
  if (image == null) throw 'Gagal decode gambar';

  // Resize image supaya max lebar 1080px (jaga rasio)
  if (image.width > 1080) {
    image = img.copyResize(image, width: 1080);
  }

  final font = img.arial_48;
  final color = img.getColor(0, 255, 0); // hijau
  const pad = 20;
  final lineHeight = font.lineHeight + 2;

  // Fungsi gambar teks tebal (simulasi bold)
  void drawBoldText(String text, int x, int y) {
    const offset = 1;
    for (int dx = 0; dx <= offset; dx++) {
      for (int dy = 0; dy <= offset; dy++) {
        img.drawString(image!, font, x + dx, y + dy, text, color: color);
      }
    }
  }

  // Split lokasi jadi baris-barisan berdasarkan koma
  List<String> lokasiParts = lokasi.split(',');

  // Trim dan ambil max 5 baris lokasi
  List<String> lokasiLines = lokasiParts.map((s) => s.trim()).take(5).toList();

  final totalLines = 2 + lokasiLines.length; // timestamp + petugas + lokasi lines
  final baseY = image.height - pad - lineHeight * totalLines;

  // Gambar teks timestamp dan petugas di bawah
  drawBoldText(timestamp, pad, baseY + lineHeight * 0);
  drawBoldText(petugas, pad, baseY + lineHeight * 1);

  // Gambar lokasi baris per baris
  for (int i = 0; i < lokasiLines.length; i++) {
    drawBoldText(lokasiLines[i], pad, baseY + lineHeight * (i + 2));
  }

  // Kompres JPG supaya max 300KB
  List<int> compressedBytes = [];
  int quality = 75;
  do {
    compressedBytes = img.encodeJpg(image, quality: quality);
    quality -= 5;
  } while (compressedBytes.length > 307200 && quality >= 10);

  return {
    'bytes': compressedBytes,
    'filename': 'stamped_${path.split('/').last}',
  };
}
