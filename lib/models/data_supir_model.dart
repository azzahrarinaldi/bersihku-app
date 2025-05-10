class DriverModel {
  final String name;
  final String vehicle;
  final String place;
  final String date;
  final String time;

  DriverModel({
    required this.name,
    required this.vehicle,
    required this.place,
    required this.date,
    required this.time,
  });

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      name: map['name'] ?? '',
      vehicle: map['PlateNumber'] ?? '',  
      place: map['place'] ?? '',                             
      date: map['date'] ?? '',
      time: map['time'] ?? '',                 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'PlateNumber': vehicle,             
      'place': place,                                                    
      'date': date,
      'time': time,                                        
    };
  }
}
