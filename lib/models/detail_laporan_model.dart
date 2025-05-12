class DetailLaporanModel {
  final String name;
  final String vehicle;
  final String place;
  final String address;
  final String time;
  final String weightTotal;
  final String urlFotoSebelum;
  final String urlFotoSesudah;

  DetailLaporanModel({
    required this.name,
    required this.vehicle,
    required this.place,
    required this.address,
    required this.time,
    required this.weightTotal,
    required this.urlFotoSebelum,
    required this.urlFotoSesudah,
  });

  factory DetailLaporanModel.fromMap(Map<String, dynamic> map) {
    return DetailLaporanModel(
      name: map['name'] ?? '',
      vehicle: map['vehicle'] ?? '',
      place: map['place'] ?? '',
      address: map['address'] ?? '',
      time: map['time'] ?? '',
      weightTotal: map['weightTotal'] ?? '',
      urlFotoSebelum: map['urlFotoSebelum'] ?? '',
      urlFotoSesudah: map['urlFotoSesudah'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'vehicle': vehicle,
      'place': place,
      'address': address,
      'time': time,
      'weightTotal': weightTotal,
      'urlFotoSebelum': urlFotoSebelum,
      'urlFotoSesudah': urlFotoSesudah,
    };
  }
}