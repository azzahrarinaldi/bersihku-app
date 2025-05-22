import 'package:bersihku/controller/detail_laporan_controller.dart';
import 'package:get/get.dart';

class DetailLaporanBinding extends Bindings {
  @override
  void dependencies() {
    // Inject DetailLaporanController hanya ketika dibutuhkan
    Get.lazyPut<DetailLaporanController>(() => DetailLaporanController());
  }
}