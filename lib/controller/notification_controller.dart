import 'package:bersihku/models/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() {
    notifications.addAll([
      NotificationModel(
        profileImage: "assets/images/profile1.png",
        name: "Budi Santoso",
        roleAndPlate: "Sopir/(B 1234 CD)",
        location: "Kemang Village Apartment",
        date: "18 Mei 2025",
        address: "Jl. Melati No. 10, Jakarta Selatan",
        notes: "Sampah berhasil diangkut tanpa kendala.",
        isNew: true,
      ),
      NotificationModel(
        profileImage: "assets/images/profile2.png",
        name: "Sari Dewi",
        roleAndPlate: "Sopir/(B 1234 CD)",
        location: "Kemang Village Apartment",
        date: "17 Mei 2025",
        address: "Jl. Anggrek No. 21, Depok",
        notes: "Terdapat keterlambatan karena hujan deras.",
        isNew: false,
      ),
    ]);
  }

  void addNotification(NotificationModel notif) {
    notifications.insert(0, notif); // Tambahkan di atas
  }

  void clearAll() {
    notifications.clear();
  }
}
