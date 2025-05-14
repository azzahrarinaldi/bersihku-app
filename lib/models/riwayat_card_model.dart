class RiwayatCardModel {
  final String place;
  final String address;
  final String date;
  final String time;

  RiwayatCardModel({
    required this.place,
    required this.address,
    required this.date,
    required this.time,
  });

  factory RiwayatCardModel.fromMap(Map<String, dynamic> map) {
    return RiwayatCardModel( 
      place: map['place'] ?? '',                             
      address: map['address'] ?? '',                             
      date: map['date'] ?? '',
      time: map['time'] ?? '',                   
    );
  }

  Map<String, dynamic> toMap() {
    return {             
      'place': place,  
      'address': address,                                                  
      'date': date,
      'time': time,                                
    };
  }
}
