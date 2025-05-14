import 'package:bersihku/models/card_data_model.dart';
import 'package:get/get.dart';

class HistoryAdminController extends GetxController {
  var cardList = <CardDataModel>[].obs;
  var filteredCardList = <CardDataModel>[].obs;
  var isDaily = true.obs;          // Make isDaily observable
  var selectedBulan = "".obs; // Make selectedBulan observable
  var searchQuery = "".obs;        // Make searchQuery observable

  @override
  void onInit() {
    fetchCards();
    super.onInit();
  }

  void fetchCards() {
    cardList.value = getDummyCardData(); // Ganti ke Firebase nanti
    filteredCardList.value = cardList; // Default: tampilkan semua dulu
  }

  void filterCardData() {
    final result = cardList.where((item) {
      // Filter berdasarkan bulan (jika laporan bulanan)
      if (!isDaily.value && selectedBulan.value.isNotEmpty) {
        final parts = item.date.split(',');
        if (parts.length < 2) return false;

        final tanggalLengkap = parts[1].trim();
        final bulan = tanggalLengkap.split(' ')[1];

        if (bulan.toLowerCase() != selectedBulan.value.toLowerCase()) {
          return false;
        }
      }

      // Filter berdasarkan nama dan tempat
      final combinedText = '${item.place} ${item.name}'.toLowerCase();
      if (!combinedText.contains(searchQuery.value.toLowerCase())) {
        return false;
      }

      return true;
    }).toList();

    filteredCardList.value = result;
  }
}
