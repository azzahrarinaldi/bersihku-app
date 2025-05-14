import 'package:bersihku/models/riwayat_card_model.dart';
import 'package:get/get.dart';

class RiwayatController extends GetxController {
  var riwayatList = <RiwayatCardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDummyData(); // ambil data dummy
  }

  void fetchDummyData() {
    riwayatList.value = [
      RiwayatCardModel(
        place: 'Kemang Village Apartment',
        address: 'Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.',
        date: 'Rabu\n26 Februari 2025',
        time: '21.00 - 06.00',
      ),
      RiwayatCardModel(
        place: 'Hotel kanay',
        address: 'Jl. Asia Afrika, Gelora, Tanah Abang',
        date: 'Kamis\n27 Februari 2025',
        time: '08.00 - 17.00',
      ),
      RiwayatCardModel(
        place: 'Hotel Mulia Senayan',
        address: 'Jl. Asia Afrika, Gelora, Tanah Abang',
        date: 'Kamis\n27 Februari 2025',
        time: '08.00 - 17.00',
      ),
    ];
  }

  // Tambah data dummy
  Future<void> addRiwayat(RiwayatCardModel item) async {
    await Future.delayed(const Duration(milliseconds: 300)); 
    riwayatList.add(item);
  }

  // Update data dummy
  Future<void> updateRiwayat(int index, RiwayatCardModel updatedItem) async {
    await Future.delayed(const Duration(milliseconds: 300));
    riwayatList[index] = updatedItem;
  }

  // Hapus data dummy
  Future<void> deleteRiwayat(int index) async {
    await Future.delayed(const Duration(milliseconds: 300));
    riwayatList.removeAt(index);
  }
}
