import 'package:bersihku/models/data_supir_model.dart';
import 'package:get/get.dart';

class DriverController extends GetxController {
  // Observable list of drivers
  var drivers = <DriverModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDrivers();
  }

  void fetchDrivers() {
    drivers.addAll([
      DriverModel(
        name: "Hadi Sucipto",
        vehicle: "B 1829 POP",
        place: "Pengangkutan terakhir",
        date: "26 Februari 2025",
        time: "21.00–06.00",
        type: "Tipe Pengangkutan", 
      ),
      DriverModel(
        name: "Joko Priyanto",
        vehicle: "B 1830 POP",
        place: "Pengangkutan terakhir",
        date: "26 Februari 2025",
        time: "21.00–06.00",
        type: "Tipe Pengangkutan",
      ),
    ]);
  }
}
