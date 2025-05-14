class DriverDetailModel {
  final String place;
  final String address;
  final String date;
  final String time;
  final String weight;

  DriverDetailModel({
    required this.place,
    required this.address,
    required this.date,
    required this.time,
    required this.weight
  });

  factory DriverDetailModel.fromMap(Map<String, dynamic> map) {
    return DriverDetailModel( 
      place: map['place'] ?? '',                             
      address: map['address'] ?? '',                             
      date: map['date'] ?? '',
      time: map['time'] ?? '', 
      weight: map['weight'] ?? ''                   
    );
  }

  Map<String, dynamic> toMap() {
    return {             
      'place': place,  
      'address': address,                                                  
      'date': date,
      'time': time,  
      'weight': weight,                                     
    };
  }
}
