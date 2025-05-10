import 'package:get/get.dart';
import '../../models/detail_data_supir_model.dart';

class DetailDataSupirController extends GetxController {
  final laporanList = <DriverDetailModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData(); // Ganti ini dengan API/fetch di kemudian hari
  }

  void loadDummyData() {
    laporanList.value = [
      DriverDetailModel(
        place: 'Mall Artha Gading',
        address: 'Jl. Artha Gading Sel. No.1, Klp. Gading Bar., Kec. Klp. Gading',
        date: '26 Februari 2025',
        time: '21.00–06.00', 
        weight: '467',
      ),
      DriverDetailModel(
        place: 'Margo City',
        address: 'Jl. Margonda Raya No.358, Kemiri Muka, Kecamatan Beji',
        date: '25 Februari 2025',
        time: '21.00–06.00', 
        weight: '467',
      ),
    ];
  }
}
