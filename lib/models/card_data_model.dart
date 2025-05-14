class CardDataModel {
  final String id;
  final String name;
  final String vehicle;
  final String place;
  final String address;
  final String date;
  final String time;
  final String type;
  final String weight;

  CardDataModel({
    required this.id,
    required this.name,
    required this.vehicle,
    required this.place,
    required this.address,
    required this.date,
    required this.time,
    required this.type,
    required this.weight,
  });

  // Untuk convert dari Map (misalnya Firebase)
  factory CardDataModel.fromMap(Map<String, dynamic> map, String id) {
    return CardDataModel(
      id: id,
      name: map['name'] ?? '',
      vehicle: map['vehicle'] ?? '',
      place: map['place'] ?? '',
      address: map['address'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      type: map['type'] ?? '',
      weight: map['weight'] ?? ''
    );
  }

  // Untuk convert ke Map (jika mau simpan ke Firebase)
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
    };
  }
}

List<CardDataModel> getDummyCardData() {
  return [
    CardDataModel(
      id: "1",
      name: "Daily Worker",
      vehicle: "B 1234 CD",
      place: "Area Perumahan",
      address: "Jl. Mawar No.12",
      date: "Selasa, 29 April 2025",
      time: "08.00 - 10.00",
      type: "Pengangkutan Sampah",
      weight: "0.980",
    ),
    CardDataModel(
      id: "2",
      name: "Abdul Kadir",
      vehicle: "B 1701 AZS",
      place: "Margo Mall City",
      address: "Jl. Margonda No.358, Kemiri Muka, Kecamatan Beji, Kota Depok",
      date: "Senin, 11 Maret 2025",
      time: "22.00 - 05.00",
      type: "Pengangkutan Sampah",
      weight: "2.100",
    ),
    CardDataModel(
      id: "3",
      name: "Joko Priyanto",
      vehicle: "B 1829 POP",
      place: "Kemang Village Apartment",
      address: "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
      date: "Rabu, 3 Mei 2025",
      time: "21.00 - 06.00",
      type: "Pengangkutan Sampah",
      weight: "1.648",
    ),
    CardDataModel(
      id: "4",
      name: "Siti Titin",
      vehicle: "B 9090 UIX",
      place: "Cilandak Town Square",
      address: "Jl. TB Simatupang No.17, Cilandak, Jakarta Selatan",
      date: "Sabtu, 6 April 2025",
      time: "20.00 - 04.00",
      type: "Pengangkutan Sampah",
      weight: "1.800",
    )
  ];
}