import 'package:flutter/material.dart';

class DetailNotifikasiAdmin extends StatefulWidget {
  const DetailNotifikasiAdmin({super.key});

  @override
  State<DetailNotifikasiAdmin> createState() => _DetailNotifikasiState();
}

class _DetailNotifikasiState extends State<DetailNotifikasiAdmin> {
  final List<Map<String, String>> dataSupir = [
    {
      "nama": "Hadi Sucipto",
      "plat": "B889N",
      "alamat": "Kemang Village Apartment",
      "tanggal": "Rabu, 26 Februari 2025",
      "lokasi": "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
      "foto": "assets/images/avatar1.png"
    },
    {
      "nama": "Joko Priyanto",
      "plat": "B889N",
      "alamat": "Kemang Village Apartment",
      "tanggal": "Rabu, 26 Februari 2025",
      "lokasi": "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
      "foto": "assets/images/avatar2.png"
    },
    {
      "nama": "Galang Sugito",
      "plat": "B889N",
      "alamat": "Kemang Village Apartment",
      "tanggal": "Rabu, 26 Februari 2025",
      "lokasi": "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
      "foto": "assets/images/avatar3.png"
    },
    {
      "nama": "Abdul Kadir",
      "plat": "B889N",
      "alamat": "Kemang Village Apartment",
      "tanggal": "Rabu, 26 Februari 2025",
      "lokasi": "Jl. Pangeran Antasari No.36, Bangka, Kec. Mampang Prpt.",
      "foto": "assets/images/avatar4.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFE9863B),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pattern_oren.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Detail Notifikasi',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.notifications_active, color: Colors.orange),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notifikasi Baru",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "Ada 1 pengangkutan terdekat hari ini.",
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.all(size.width * 0.05),
                      itemCount: dataSupir.length,
                      itemBuilder: (context, index) {
                        final item = dataSupir[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.04),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Profil supir
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: size.width * 0.07,
                                      backgroundImage: AssetImage(item['foto']!),
                                    ),
                                    SizedBox(width: size.width * 0.03),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  item['nama']!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: size.width * 0.035,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: size.width * 0.015),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  item['alamat']!,
                                                  style: TextStyle(
                                                    color: Colors.orange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: size.width * 0.025,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Sopir / (${item['plat']})",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: size.width * 0.03,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: size.height * 0.015),

                                // TextField Catatan
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan catatan...',
                                      hintStyle: TextStyle(
                                          fontSize: size.width * 0.03),
                                      suffixIcon: Container(
                                        margin: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.send,
                                              color: Colors.white, size: 16),
                                          onPressed: () {},
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(
                                        maxHeight: 36,
                                        maxWidth: 36,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),

                                SizedBox(height: size.height * 0.015),

                                const Text(
                                  "Pengangkutan terakhir",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                SizedBox(height: size.height * 0.01),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(Icons.fiber_manual_record,
                                            size: 14, color: Colors.lightBlue),
                                        Container(
                                          width: 2,
                                          height: size.height * 0.04,
                                          color: Colors.lightBlue,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: size.width * 0.02),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item['tanggal']!),
                                          Text(item['lokasi']!),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
