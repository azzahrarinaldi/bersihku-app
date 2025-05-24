// detail_data_supir_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

/// Model untuk detail data supir
class DetailDataSupirModel {
  final String place;
  final String address;
  final DateTime createdAt;
  final double weightTotal;
  final String profilePicture;
  final String phone;
  final String name;
  final String vehicle;

  DetailDataSupirModel({
    required this.place,
    required this.address,
    required this.createdAt,
    required this.weightTotal,
    required this.profilePicture,
    required this.phone,
    required this.name,
    required this.vehicle,
  });

  /// Membuat instance dari Map (Firestore document)
  factory DetailDataSupirModel.fromMap(Map<String, dynamic> map) {
    // Parsing timestamp
    final rawDate = map['created_at'];
    final DateTime createdAt = rawDate is Timestamp
        ? rawDate.toDate()
        : rawDate is String
            ? DateTime.tryParse(rawDate) ?? DateTime.now()
            : DateTime.now();

    // Parsing berat keseluruhan
    final rawWeight = map['berat_keseluruhan'];
    final double weightTotal = rawWeight is num
        ? rawWeight.toDouble()
        : rawWeight is String
            ? double.tryParse(rawWeight) ?? 0
            : 0;

    // Parsing nomor telepon (String)
    final String phone = map['phone']?.toString() ?? '';

    return DetailDataSupirModel(
      place           : map['lokasi']?.toString() ?? '',
      address         : map['alamat']?.toString() ?? '',
      createdAt       : createdAt,
      weightTotal     : weightTotal,
      profilePicture  : map['profile_picture']?.toString() ?? '',
      phone           : phone,
      name            : map['name']?.toString() ?? '',
      vehicle         : map['plat_nomor']?.toString() ?? '',
    );
  }

  /// Mengonversi instance ke Map untuk disimpan ke Firestore
  Map<String, dynamic> toMap() => {
        'lokasi'            : place,
        'alamat'            : address,
        'created_at'        : createdAt,
        'berat_keseluruhan' : weightTotal,
        'profile_picture'   : profilePicture,
        'phone'             : phone,
        'name'              : name,
        'plat_nomor'        : vehicle,
      };

  String get formattedWeight {
    if (weightTotal % 1 == 0) {
      return weightTotal.toInt().toString();
    } else {
      return weightTotal.toStringAsFixed(2);
    }
  }
}
