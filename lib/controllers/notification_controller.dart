import 'package:get/get.dart';
import 'package:bersihku/models/notification_model.dart';

class NotificationController extends GetxController {
  // List notifikasi
  var notificationList = <NotificationModel>[].obs;

  // Loading state
  var isLoading = false.obs;

  // Simulasi fetch data dari API atau database
  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;

      // Simulasi delay, ganti ini dengan API call asli
      await Future.delayed(const Duration(seconds: 2));

      // Contoh data, bisa diganti dengan response dari API
      List<Map<String, dynamic>> dummyData = [
        {
          'image': 'assets/images/profile-person-history.png',
          'name': 'Budi Santoso',
          'PlateNumber': 'B 1234 CD',
          'place': 'Kemang Village Apartment',
          'address': 'Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.',
          'date': 'Rabu, 26 Februari 2025',
          'time': '10:00',
        },
        {
          'image': 'assets/images/profile-person-history.png',
          'name': 'Siti Rahma',
          'PlateNumber': 'D 5678 EF',
          'place': 'Kemang Village Apartment',
          'address': 'Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.',
          'date': 'Rabu, 26 Februari 2025',
          'time': '09:30',
        },
      ];

      // Mapping ke model
      notificationList.value = dummyData
          .map((data) => NotificationModel.fromMap(data))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat notifikasi');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }
}
