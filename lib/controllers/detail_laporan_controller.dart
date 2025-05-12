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
        name: "Joko Priyanto",
        vehicle: "B 1829 POP",
        place: "Margo City",
        address: "Jl. Margonda Raya No.358, Kemiri Muka, Kecamatan Beji",
        time: "Rabu, 26 Februari 2025 07.00 - 09.00",
        weightTotal: "580 kg",
        urlFotoSebelum: "assets/images/sampah-kering-img.png",
        urlFotoSesudah: "assets/images/sampah-kering-img.png",
      ),
      DetailLaporanModel(
        name: "Joko Priyanto",
        vehicle: "B 1829 POP",
        place: "Margo City",
        address: "Jl. Margonda Raya No.358, Kemiri Muka, Kecamatan Beji",
        time: "Rabu, 26 Februari 2025 10.00 - 12.00",
        weightTotal: "670 kg",
        urlFotoSebelum: "assets/images/sampah-kering-img.png",
        urlFotoSesudah: "assets/images/sampah-kering-img.png",
      ),
      DetailLaporanModel(
        name: "Joko Priyanto",
        vehicle: "B 1829 POP",
        place: "Margo City",
        address: "Jl. Margonda Raya No.358, Kemiri Muka, Kecamatan Beji",
        time: "Rabu, 26 Februari 2025 10.00 - 12.00",
        weightTotal: "7.050 kg",
        urlFotoSebelum: "assets/images/sampah-kering-img.png",
        urlFotoSesudah: "assets/images/sampah-kering-img.png",
      ),
    ];
  }
}