// lib/bindings/detail_data_supir_binding.dart

import 'package:bersihku/controller/detail_data_supir_controller.dart';
import 'package:get/get.dart';

class DetailDataSupirBinding extends Bindings {
  @override
  void dependencies() {
    // Ambil supirId dari Get.arguments
    final supirId = Get.arguments as String;

    // Lazy‐put controller dengan menyertakan supirId
    Get.lazyPut<DetailDataSupirController>(
      () => DetailDataSupirController(supirId),
    );
  }
}
