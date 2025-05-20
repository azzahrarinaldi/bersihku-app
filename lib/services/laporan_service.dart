import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LaporanService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<DetailLaporanModel>> fetchAllLaporan() async {
    final snap = await _firestore.collection('laporan_pengangkutan').get();
    final temp = <DetailLaporanModel>[];

    for (var doc in snap.docs) {
      final data = doc.data();

      // Fetch user data untuk amankan user info
      final userSnap = await _firestore.collection('users').doc(data['userId']).get();
      final userData = userSnap.data() ?? {};
      data['name'] = userData['name'] ?? 'Unknown';
      data['profile_picture'] = userData['profile_picture'] ?? '';

      temp.add(DetailLaporanModel.fromMap(data, doc.id));
    }

    return temp;
  }
}
