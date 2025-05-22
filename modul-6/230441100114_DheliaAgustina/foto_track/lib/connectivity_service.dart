import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Future<String> checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) return "Mobile Data";
    if (result == ConnectivityResult.wifi) return "WiFi";
    return "No Internet";
  }
}
