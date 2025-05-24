class HistoryModel {
  final String documentId;
  final String name;
  final String vehicle;
  final String place;
  final String address;
  final String date;
  final String time;
  final String type;
  final String weight;
  final String profileImage; 

  HistoryModel({
    required this.documentId,
    required this.name,
    required this.vehicle,
    required this.place,
    required this.address,
    required this.date,
    required this.time,
    required this.type,
    required this.weight,
    required this.profileImage,
  });

  factory HistoryModel.fromMap(String documentId, Map<String, dynamic> map) {
    return HistoryModel(
      documentId: documentId,
      name: map['name'] ?? '',
      vehicle: map['vehicle'] ?? '',
      place: map['place'] ?? '',
      address: map['address'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      type: map['type'] ?? '',
      weight: map['weight'] ?? '',
      profileImage: map['profile_image'] ?? '', // pastikan nama key sesuai DB
    );
  }

  // konversi ke Map untuk ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'vehicle': vehicle,
      'place': place,
      'address': address,
      'date': date,
      'time': time,
      'type': type,
      'weight': weight,
      'profile_image': profileImage,
    };
  }
}
