class DataSupirProfileModel {
   final String image;
  final String name;
  final String userWhatsApp;
  final String vehicle;

  DataSupirProfileModel({
    required this.image,
    required this.name,
    required this.vehicle,
    required this.userWhatsApp,
  });

  factory DataSupirProfileModel.fromMap(Map<String, dynamic> map) {
    return DataSupirProfileModel(
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      vehicle: map['PlateNumber'] ?? '',  
      userWhatsApp: map ['whatsApp']               
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'PlateNumber': vehicle,             
      'whatsApp': userWhatsApp,                                      
    };
  }
}
