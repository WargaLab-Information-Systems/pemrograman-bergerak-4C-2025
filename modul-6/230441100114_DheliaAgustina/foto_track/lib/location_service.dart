import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Map<String, double>> getLocation() async {
    await Geolocator.requestPermission();
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return {"latitude": pos.latitude, "longitude": pos.longitude};
  }
}
