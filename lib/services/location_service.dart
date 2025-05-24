import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<String> getLocationText() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return '[Lokasi tidak aktif]';

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever ||
            permission == LocationPermission.denied) {
          return '[Izin lokasi ditolak]';
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return '${p.street}, ${p.subLocality}, ${p.locality}, ${p.administrativeArea}, ${p.postalCode}';
      } else {
        return '[Alamat tidak ditemukan]';
      }
    } catch (e) {
      return '[Gagal mengambil lokasi]';
    }
  }
}
