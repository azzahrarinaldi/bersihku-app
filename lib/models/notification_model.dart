class NotificationModel {
  final String image;
  final String name;
  final String vehicle;
  final String place;
  final String date;
  final String address;
  final String time;

  NotificationModel({
    required this.image,
    required this.name,
    required this.vehicle,
    required this.place,
    required this.date,
    required this.address,
    required this.time,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      image: map['image'],
      name: map['name'] ?? '',
      vehicle: map['PlateNumber'] ?? '',  
      place: map['place'] ?? '',                             
      date: map['date'] ?? '',
      address: map['address'] ?? '',                 
      time: map['time'] ?? '',                  
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'PlateNumber': vehicle,             
      'place': place,                                                    
      'date': date,
      'address': address,                                        
      'time': time,                                        
    };
  }
}
