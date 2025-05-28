// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:http/http.dart' as http;
// import '../models/captured_image.dart';

// class NetworkService {
//   static Future<bool> hasInternetConnection() async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       return false;
//     }

//     try {
//       final response = await http.get(
//         Uri.parse('https://www.google.com'),
//         headers: {'Cache-Control': 'no-cache'},
//       );
//       return response.statusCode == 200;
//     } catch (e) {
//       return false;
//     }
//   }

//   static Future<void> uploadImage(CapturedImage image) async {
//     if (!await hasInternetConnection()) {
//       throw Exception('No internet connection');
//     }

//     final uri = Uri.parse('https://your-api-endpoint.com/upload');
//     final request =
//         http.MultipartRequest('POST', uri)
//           ..files.add(await http.MultipartFile.fromPath('image', image.path))
//           ..fields['description'] = image.description
//           ..fields['latitude'] = image.latitude.toString()
//           ..fields['longitude'] = image.longitude.toString();

//     final response = await request.send();
//     if (response.statusCode != 200) {
//       throw Exception('Upload failed');
//     }
//   }
// }
