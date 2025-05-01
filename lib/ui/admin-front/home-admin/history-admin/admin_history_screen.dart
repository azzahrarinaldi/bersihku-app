import 'package:bersihku/ui/admin-front/home-admin/history-admin/components/dropdown_bulan.dart';
import 'package:flutter/material.dart';
import 'components/admin_history_card.dart';

class AdminHistoryScreen extends StatefulWidget {
  const AdminHistoryScreen({super.key});

  @override
  State<AdminHistoryScreen> createState() => _AdminHistoryScreenState();
}

class _AdminHistoryScreenState extends State<AdminHistoryScreen> {
  bool isDaily = true;
  String selectedBulan = "Pilih Bulan";

  final List<String> bulanList = [
    "Pilih Bulan",
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

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
        "address": "Jl. Margonda No.358, Kemiri Muka, Kecamatan Beji, Kota Depok",
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

  List<Map<String, String>> getFilteredData() {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final filteredData = getFilteredData();

    return Scaffold(
      backgroundColor: const Color(0xFF4EBAE5),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blue-pettern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: 20,
                ),
                child: const Text(
                  "Riwayat Laporan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Cari Riwayat..",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Icon(Icons.search, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isDaily = true),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: isDaily ? const Color(0xFFFDD835) : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Laporan Harian",
                              style: TextStyle(
                                color: isDaily ? Colors.black87 : Colors.white,
                                fontWeight: isDaily ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isDaily = false),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: !isDaily ? const Color(0xFFFDD835) : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Laporan Bulanan",
                              style: TextStyle(
                                color: !isDaily ? Colors.black87 : Colors.white,
                                fontWeight: !isDaily ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        if (!isDaily)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DropdownBulan(
                                selectedBulan: selectedBulan,
                                BulanList: bulanList,
                                onChanged: (newBulan) {
                                  setState(() {
                                    selectedBulan = newBulan;
                                  });
                                },
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: filteredData.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Tidak ada data untuk laporan ini.",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: filteredData.length,
                                  itemBuilder: (context, index) {
                                    final item = filteredData[index];
                                    return Column(
                                      children: [
                                        AdminHistoryCard(
                                          name: item["name"]!,
                                          vehicle: item["vehicle"]!,
                                          place: item["place"]!,
                                          address: item["address"]!,
                                          date: item["date"]!,
                                          time: item["time"]!,
                                          type: item["type"]!,
                                          weight: item["weight"]!,
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
