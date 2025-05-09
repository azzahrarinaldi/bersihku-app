import 'package:bersihku/models/card_history_model.dart';
import 'package:get/get.dart';

class LaporanMasukController extends GetxController {
  var selectedWilayah = 'Pilih Wilayah'.obs;

  final List<String> wilayahList = [
    'Pilih Wilayah',
    'Margo City',
    'Kuningan City',
    'Mall Artha Gading',
  ];

  final List<CardDataModel> allData = [
    CardDataModel(
      name: "Joko Priyanto",
      vehicle: "B 1829 POP",
      place: "Mall Artha Gading",
      address: "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
      date: "Rabu, 26 Februari 2025",
      time: "21.00–06.00",
      type: "Pengangkutan Sampah",
      weight: "1.648",
    ),
    CardDataModel(
      name: "Joko Priyanto",
      vehicle: "B 1829 POP",
      place: "Kuningan City",
      address: "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
      date: "Rabu, 26 Februari 2025",
      time: "21.00–06.00",
      type: "Pengangkutan Sampah",
      weight: "1.648",
    ),
    CardDataModel(
      name: "Joko Priyanto",
      vehicle: "B 1829 POP",
      place: "Margo City",
      address: "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
      date: "Rabu, 26 Februari 2025",
      time: "21.00–06.00",
      type: "Pengangkutan Sampah",
      weight: "1.648",
    ),
  ];

  List<CardDataModel> get filteredList {
    if (selectedWilayah.value == 'Pilih Wilayah') {
      return allData;
    } else {
      return allData
          .where((item) => item.place == selectedWilayah.value)
          .toList();
    }
  }

  void updateWilayah(String wilayah) {
    selectedWilayah.value = wilayah;
  }
}
