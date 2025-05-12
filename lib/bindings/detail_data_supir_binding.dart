import 'package:bersihku/controllers/detail_data_supir_controller.dart';
import 'package:get/get.dart';

class DetailDataSupirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDataSupirController>(() => DetailDataSupirController());
  }
}