import 'package:bersihku/ui/admin-front/history-admin/components/admin_history_data.dart';

List<Map<String, String>> getFilteredData({
  required bool isDaily,
  required String selectedBulan,
  required String searchQuery,
}) {
  return getAllCardData().where((item) {
    // Filter berdasarkan bulan (jika laporan bulanan)
    if (!isDaily && selectedBulan != "Pilih Bulan") {
      final date = item['date'];
      if (date == null) return false;

      final parts = date.split(',');
      if (parts.length < 2) return false;
      
      final tanggalLengkap = parts[1].trim();
      final bulan = tanggalLengkap.split(' ')[1];

      if (bulan.toLowerCase() != selectedBulan.toLowerCase()) {
        return false;
      }
    }

    // Filter berdasarkan nama tempat
    final tempat = item['place'] ?? '';
    final nama = item['name'] ?? '';
    final combinedText = '$tempat $nama'.toLowerCase();
     if (!combinedText.contains(searchQuery.toLowerCase())) {
      return false;
    }

    return true;
  }).toList();
}
