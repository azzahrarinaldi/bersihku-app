List<Map<String, String>> getAllCardData() {
  return [
    {
      "name": "Daily Worker",
      "vehicle": "B 1234 CD",
      "place": "Area Perumahan",
      "address": "Jl. Mawar No.12",
      "date": "Selasa, 29 April 2025",
      "time": "08.00 - 10.00",
      "type": "Pengangkutan Sampah",
      "weight": "0.980",
    },
    {
      "name": "Joko Priyanto",
      "vehicle": "B 1829 POP",
      "place": "Kemang Village Apartment",
      "address": "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
      "date": "Rabu, 26 Februari 2025",
      "time": "21.00 - 06.00",
      "type": "Pengangkutan Sampah",
      "weight": "1.648",
    },
    {
      "name": "Abdul Kadir",
      "vehicle": "B 1701 AZS",
      "place": "The Margo Hotel",
      "address":
          "Jl. Margonda No.358, Kemiri Muka, Kecamatan Beji, Kota Depok",
      "date": "Senin, 11 Maret 2025",
      "time": "22.00 - 05.00",
      "type": "Pengangkutan Limbah",
      "weight": "2.100",
    },
    {
      "name": "Siti Titin",
      "vehicle": "B 9090 UIX",
      "place": "Cilandak Town Square",
      "address": "Jl. TB Simatupang No.17, Cilandak, Jakarta Selatan",
      "date": "Sabtu, 6 April 2025",
      "time": "20.00 - 04.00",
      "type": "Pembersihan Jalan",
      "weight": "1.800",
    },
  ];
}

List<Map<String, String>> getFilteredData({
  required bool isDaily,
  required String selectedBulan,
}) {
  if (isDaily || selectedBulan == "Pilih Bulan") {
    return getAllCardData();
  }

  switch (selectedBulan) {
    case "Februari":
      return [getAllCardData()[1]];
    case "Maret":
      return [getAllCardData()[2]];
    case "April":
      return [getAllCardData()[3]];
    default:
      return [];
  }
}