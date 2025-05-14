import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:get/get.dart';

class DetailLaporanController extends GetxController {
  var laporanList = <DetailLaporanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDummyData();
  }

  void fetchDummyData() {
    laporanList.value = [
      DetailLaporanModel(
        id: "1",
        name: "Joko Priyanto",
        vehicle: "B 1829 POP",
        place: "Mall Artha Gading",
        address:
            "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
        time: "Rabu, 26 Februari 2025 21.00–06.00",
        weightTotal: "1.648 kg",
        urlFotoSebelum: "assets/images/sampah-kering-sebelum-diangkat.png",
        urlFotoSesudah: "assets/images/sampah-kering-img.png",
      ),
      DetailLaporanModel(
        id: "2",
        name: "Joko Priyanto",
        vehicle: "B 1829 POP",
        place: "Kuningan City",
        address:
            "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
        time: "Rabu, 26 Februari 2025 21.00–06.00",
        weightTotal: "1.648 kg",
        urlFotoSebelum: "assets/images/sampah-kering-sebelum-diangkat.png",
        urlFotoSesudah: "assets/images/sampah-kering-img.png",
      ),
      DetailLaporanModel(
        id: "3",
        name: "Joko Priyanto",
        vehicle: "B 1829 POP",
        place: "Margo City",
        address:
            "Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading",
        time: "Rabu, 26 Februari 2025 21.00–06.00",
        weightTotal: "1.648 kg",
        urlFotoSebelum: "assets/images/sampah-kering-sebelum-diangkat.png",
        urlFotoSesudah: "assets/images/sampah-kering-img.png",
      ),
    ];
  }

  DetailLaporanModel? getLaporanById(String id) {
    return laporanList.firstWhereOrNull((laporan) => laporan.id == id);
  }

  int getJumlahLaporanByName(String name) {
    return laporanList.where((laporan) => laporan.name == name).length;
  }
}
