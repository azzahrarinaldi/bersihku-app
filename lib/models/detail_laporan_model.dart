import 'package:cloud_firestore/cloud_firestore.dart';

class DetailLaporanModel {
  final String id;
  final String userId; 
  final String name;
  final String profilePicture;
  final String vehicle;
  final String place;
  final String address;
  final DateTime createdAt;
  final double weightTotal;
  final List<String> imagesBasah;
  final List<String> imagesKering;

  DetailLaporanModel({
    required this.id,
    required this.userId, 
    required this.name,
    required this.profilePicture,
    required this.vehicle,
    required this.place,
    required this.address,
    required this.createdAt,
    required this.weightTotal,
    required this.imagesBasah,
    required this.imagesKering,
  });

  factory DetailLaporanModel.fromMap(Map<String, dynamic> map, String id) {
    // createdAt & weight parsing seperti biasa
    late DateTime createdAt;
    final rawDate = map['created_at'];
    if (rawDate is Timestamp) {
      createdAt = rawDate.toDate();
    } else if (rawDate is String) {
      createdAt = DateTime.tryParse(rawDate) ?? DateTime.now();
    } else {
      createdAt = DateTime.now();
    }

    late double weightTotal;
    final rawWeight = map['berat_keseluruhan'];
    if (rawWeight is num) {
      weightTotal = rawWeight.toDouble();
    } else if (rawWeight is String) {
      weightTotal = double.tryParse(rawWeight) ?? 0;
    } else {
      weightTotal = 0;
    }

    return DetailLaporanModel(
      id: id,
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      profilePicture: map['profile_picture'] ?? '',
      vehicle: map['plat_nomor'] ?? '',
      place: map['lokasi']?.toString() ?? '',
      address: map['alamat'] ?? '',
      createdAt: createdAt,
      weightTotal: weightTotal,
      imagesBasah: List<String>.from(map['images_basah'] ?? []),
      imagesKering: List<String>.from(map['images_kering'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'profile_picture': profilePicture,
        'plat_nomor': vehicle,
        'lokasi': place,
        'alamat': address,
        'created_at': createdAt.toIso8601String(),
        'berat_keseluruhan': weightTotal,
        'images_basah': imagesBasah,
        'images_kering': imagesKering,
      };

  String get formattedWeight {
    if (weightTotal % 1 == 0) {
      return weightTotal.toInt().toString();
    } else {
      return weightTotal.toStringAsFixed(2);
    }
  }
}
