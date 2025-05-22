// import 'package:flutter/material.dart';
// import 'photo_page.dart';
// import 'gallery_page.dart';
// import 'notification_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NotificationService().init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Foto & Lokasi',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: 'Roboto',
//       ),
//       home: HomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.camera_alt, size: 100, color: Colors.white),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'FotoTrack',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.camera_alt_outlined),
//                   label: const Text('Ambil Foto'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.blueAccent,
//                     elevation: 4,
//                   ),
//                   onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => PhotoPage()),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.photo_library_outlined),
//                   label: const Text('Riwayat Foto'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.blueAccent,
//                     elevation: 4,
//                   ),
//                   onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => GalleryPage(photoData: []),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'photo_page.dart';
import 'gallery_page.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foto & Lokasi',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFFFE5B4), // Peach background
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Row dengan 3 Card foto besar
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPolaroid(context, 'image/p.jpg', -10),
                    const SizedBox(width: 16),
                    _buildPolaroid(context, 'image/r.jpg', 0),
                    const SizedBox(width: 16),
                    _buildPolaroid(context, 'image/s.jpg', 10),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Ambil Foto'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: const Color(0xFFFFA94D), // Orange pastel
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PhotoPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo_library_outlined),
                      label: const Text('Riwayat Foto'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: const Color(0xFFA8D5BA), // Mint hijau pastel
                        foregroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => GalleryPage(photoData: [])),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Polaroid-style Card BESAR
  Widget _buildPolaroid(BuildContext context, String imagePath, double angle) {
    return Transform.rotate(
      angle: angle * 3.1416 / 180, // derajat ke radian
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 140,
          height: 170,
          padding: const EdgeInsets.all(6),
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '', // Bisa diisi nama atau tanggal
                style: TextStyle(fontSize: 12),
              ),
            ], 
          ),
        ),
      ),
    );
  }
}

