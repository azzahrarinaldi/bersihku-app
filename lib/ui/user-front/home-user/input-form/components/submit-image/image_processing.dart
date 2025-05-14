import 'dart:typed_data';
import 'package:image/image.dart' as img;

Future<Map<String, dynamic>> processImageInIsolate(Map<String, dynamic> args) async {
  final raw = args['raw'] as List<int>;
  final timestamp = args['timestamp'] as String;
  final petugas = args['petugas'] as String;
  final lokasi = args['lokasi'] as String;
  final path = args['path'] as String;

  img.Image? image = img.decodeImage(Uint8List.fromList(raw));
  if (image == null) throw 'Gagal decode gambar';

  final font = img.arial_48;
  final color = img.getColor(0, 255, 0);
  const pad = 40;
  final lineHeight = font.lineHeight + 2;
  final baseY = image.height - pad - lineHeight * 4;

  img.drawString(image, font, pad, baseY + lineHeight * 0, timestamp, color: color);
  img.drawString(image, font, pad, baseY + lineHeight * 1, petugas, color: color);

  String locationLine1 = lokasi.length > 50 ? lokasi.substring(0, 50) + '...' : lokasi;
  String locationLine2 = lokasi.length > 100 ? lokasi.substring(50, 100) + '...' : '';

  img.drawString(image, font, pad, baseY + lineHeight * 2, locationLine1, color: color);
  if (locationLine2.isNotEmpty) {
    img.drawString(image, font, pad, baseY + lineHeight * 3, locationLine2, color: color);
  }

  List<int> compressedBytes;
  int quality = 85;
  do {
    compressedBytes = img.encodeJpg(image, quality: quality);
    quality -= 5;
  } while (compressedBytes.length > 300 * 1024 && quality > 10);

  return {
    'bytes': compressedBytes,
    'filename': 'stamped_${path.split('/').last}',
  };
}
