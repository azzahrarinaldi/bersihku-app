class NotificationModel {
  final String profileImage;
  final String name;
  final String roleAndPlate;
  final String location;
  final String date;
  final String address;
  final String notes;
  final bool isNew;

  NotificationModel({
    required this.profileImage,
    required this.name,
    required this.roleAndPlate,
    required this.location,
    required this.date,
    required this.address,
    required this.notes,
    this.isNew = false,
  });
}
