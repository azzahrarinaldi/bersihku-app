import 'package:cloud_firestore/cloud_firestore.dart';

class RiwayatCardModel {
  final String place;
  final String address;
  final String date;
  final String time;
  final String plate;

  RiwayatCardModel({
    required this.place,
    required this.address,
    required this.date,
    required this.time,
    required this.plate,
  });

  factory RiwayatCardModel.fromMap(Map<String, dynamic> map) {
    final Timestamp? timestamp = map['created_at'];
    DateTime dateTime = timestamp != null ? timestamp.toDate() : DateTime.now();

    return RiwayatCardModel(
      place: map['lokasi'] ?? '',
      address: map['alamat'] ?? '',
      plate: map['plat_nomor'] ?? '',
      date: "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}",
      time: "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
    );
  }

  Map<String, dynamic> toMap() {
    return {             
      'lokasi': place,  
      'alamat': address,                                                  
      'date': date,
      'time': time,
      'plat_nomor': plate,                                
    };
  }
}
