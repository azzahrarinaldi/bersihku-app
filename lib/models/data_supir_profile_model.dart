class DataSupirProfileModel {
  final String name;
  final String userWhatsApp;
  final String vehicle;

  DataSupirProfileModel({
    required this.name,
    required this.vehicle,
    required this.userWhatsApp,
  });

  factory DataSupirProfileModel.fromMap(Map<String, dynamic> map) {
    return DataSupirProfileModel(
      name: map['name'] ?? '',
      vehicle: map['PlateNumber'] ?? '',  
      userWhatsApp: map ['whatsApp']               
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'PlateNumber': vehicle,             
      'whatsApp': userWhatsApp,                                      
    };
  }
}
