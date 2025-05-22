// import 'package:flutter/material.dart';

// class GalleryPage extends StatelessWidget {
//   // Simulasi data dummy
//   final List<Map<String, String>> photoData = [
//     {"image": "assets/sample.jpg", "location": "(-6.200000, 106.816666)"},
//     {"image": "assets/sample.jpg", "location": "(-6.914744, 107.609810)"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Riwayat Foto')),
//       body: ListView.builder(
//         itemCount: photoData.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Image.asset(photoData[index]['image']!),
//             title: Text('Lokasi: ${photoData[index]['location']}'),
//           );
//         },
//       ),
//     );
//   }
// }


// gallery_page.dart

import 'dart:io';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final List<Map<String, String>> photoData;

  GalleryPage({required this.photoData}); // menerima data dari luar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Foto')),
      body: photoData.isEmpty
          ? Center(child: Text('Belum ada foto disimpan.'))
          : ListView.builder(
              itemCount: photoData.length,
              itemBuilder: (context, index) {
                final item = photoData[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: File(item['image']!).existsSync()
                        ? Image.file(File(item['image']!), width: 64, height: 64, fit: BoxFit.cover)
                        : Icon(Icons.image),
                    title: Text(item['title'] ?? 'Tanpa Judul'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deskripsi: ${item['description']}'),
                        Text('Kategori: ${item['category']}'),
                        Text('Tanggal: ${item['date']}'),
                        Text('Lokasi: ${item['location']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
