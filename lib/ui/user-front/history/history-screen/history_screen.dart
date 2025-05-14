import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bersihku/ui/user-front/history/history-screen/components/history_card.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<String> userNameFuture;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    userNameFuture = getUserName();
  }

  Stream<QuerySnapshot> getUserReports() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return FirebaseFirestore.instance
        .collection('laporan_pengangkutan')
        .where('userId', isEqualTo: uid)
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  Future<String> getUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return 'Pengguna';
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot.data()?['name'] ?? 'Pengguna';
  }

  String formatTanggal(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
  }

  String formatWaktu(DateTime date) {
    return '${DateFormat('HH:mm', 'id_ID').format(date)} WIB';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
          child: FutureBuilder<String>(
            future: userNameFuture,
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              final userName = userSnapshot.data ?? 'Pengguna';

              return StreamBuilder<QuerySnapshot>(
                stream: getUserReports(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data?.docs ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: 15,
                        ),
                        child: const Text(
                          "Riwayat Pengangkutan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (docs.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: HistoryCard(
                            documentId: docs.first.id,
                            name: userName,
                            vehicle: docs.first['plat_nomor'] ?? '',
                            place: docs.first['lokasi'] ?? '',
                            address: docs.first['alamat'] ?? '',
                            date: formatTanggal((docs.first['created_at'] as Timestamp).toDate()),
                            time: formatWaktu((docs.first['created_at'] as Timestamp).toDate()),
                            type: 'Pengangkutan Sampah',
                            weight: docs.first['berat_keseluruhan']?.toString() ?? '0',
                          ),
                        ),
                      ] else
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Belum ada data laporan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: docs.length <= 1
                              ? const Center(child: Text('Belum ada riwayat lainnya'))
                              : ListView.builder(
                                  padding: const EdgeInsets.all(20),
                                  itemCount: docs.length - 1,
                                  itemBuilder: (context, index) {
                                    final doc = docs[index + 1];
                                    final data = doc.data() as Map<String, dynamic>;
                                    final createdAt = (data['created_at'] as Timestamp).toDate();
                                    return HistoryCard(
                                      documentId: doc.id,
                                      name: userName,
                                      vehicle: data['plat_nomor'] ?? '',
                                      place: data['lokasi'] ?? '',
                                      address: data['alamat'] ?? '',
                                      date: formatTanggal(createdAt),
                                      time: formatWaktu(createdAt),
                                      type: 'Pengangkutan Sampah',
                                      weight: data['berat_keseluruhan']?.toString() ?? '0',
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
