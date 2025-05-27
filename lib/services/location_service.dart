import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
 static Future<String> getLocationText({Duration timeout = const Duration(seconds: 5)}) async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return '[Lokasi tidak aktif]';

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        return '[Izin lokasi ditolak]';
      }
    }

    Position position = await Geolocator.getCurrentPosition().timeout(timeout);

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;

      // Ambil nama gedung/tempat yang paling lengkap & prioritas
      String name = p.name ?? '';
      String subThoroughfare = p.subThoroughfare ?? '';
      String thoroughfare = p.thoroughfare ?? '';
      String street = p.street ?? '';
      String subLocality = p.subLocality ?? '';
      String locality = p.locality ?? '';
      String administrativeArea = p.administrativeArea ?? '';
      String postalCode = p.postalCode ?? '';

      // Buat list alamat dengan prioritas nama gedung/tempat dulu
      final parts = <String>[];

      if (name.isNotEmpty) parts.add(name);  // nama gedung/sekolah
      else if (subThoroughfare.isNotEmpty) parts.add(subThoroughfare); // nomor gedung

      if (thoroughfare.isNotEmpty) parts.add(thoroughfare); // nama jalan
      else if (street.isNotEmpty) parts.add(street);

      if (subLocality.isNotEmpty) parts.add(subLocality);
      if (locality.isNotEmpty) parts.add(locality);
      if (administrativeArea.isNotEmpty) parts.add(administrativeArea);
      if (postalCode.isNotEmpty) parts.add(postalCode);

      if (parts.isEmpty) {
        return '[Alamat tidak ditemukan]';
      }

      return parts.join(', ');
    } else {
      return '[Alamat tidak ditemukan]';
    }
  } catch (e) {
    return '[Gagal mengambil lokasi]';
  }
}

}
