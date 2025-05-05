import 'package:flutter/material.dart';
import 'detail.dart';
import 'add_wisata.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MODUL 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to store attractions
  List<Map<String, dynamic>> wisataList = [
    {
      'nama': 'National Park Yosemite',
      'lokasi': 'California',
      'jenis': 'Alam',
      'harga': '30000',
      'deskripsi': 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis, doloribus. Eos, accusantium doloremque! Tenetur, sed.',
      'imagePath': 'lib/images/gambar.png',
      'isCustomImage': false,
      'webImage': null,
    },
    {
      'nama': 'National Park Yosemite',
      'lokasi': 'California',
      'jenis': 'Alam',
      'harga': '30000',
      'deskripsi': 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis, doloribus. Eos, accusantium doloremque! Tenetur, sed.',
      'imagePath': 'lib/images/gambar.png',
      'isCustomImage': false,
      'webImage': null,
    },
    {
      'nama': 'National Park Yosemite',
      'lokasi': 'California',
      'jenis': 'Alam',
      'harga': '30000',
      'deskripsi': 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis, doloribus. Eos, accusantium doloremque! Tenetur, sed.',
      'imagePath': 'lib/images/gambar.png',
      'isCustomImage': false,
      'webImage': null,
    },
    {
      'nama': 'National Park Yosemite',
      'lokasi': 'California',
      'jenis': 'Alam',
      'harga': '30000',
      'deskripsi': 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis, doloribus. Eos, accusantium doloremque! Tenetur, sed.',
      'imagePath': 'lib/images/gambar.png',
      'isCustomImage': false,
      'webImage': null,
    },
  ];

  // Function to add new attraction
  void _addWisata(Map<String, dynamic> newWisata) {
    setState(() {
      wisataList.add(newWisata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            "Hi, User",
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 24,
              color: Colors.black
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddWisataScreen(onAddWisata: _addWisata),
            ),
          );
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          // Hot Places Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hot Places",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "See All",
                  style: TextStyle(color: Color(0xFF727272), fontSize: 14),
                ),
              ],
            ),
          ),

          // Hot Places Horizontal List
          Container(
            height: 90, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: wisataList.length,
              itemBuilder: (context, index) {
                final wisata = wisataList[index];
                return Container(
  margin: EdgeInsets.only(right: 12),
  width: 240, // diperbesar agar muat gambar dan teks
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    children: [
      
      ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        child: SizedBox(
          width: 80,
          height: 80,
          child: _buildWisataImage(wisata),
        ),
      ),
    
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                wisata['nama'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                wisata['lokasi'],
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

              },
            ),
          ),

          // Best Hotels Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Best Hotels",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "See All",
                  style: TextStyle(color: Color(0xFF727272), fontSize: 14),
                ),
              ],
            ),
          ),

          // Best Hotels Vertical List
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            itemCount: wisataList.length,
            itemBuilder: (context, index) {
              final wisata = wisataList[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailScreen(wisata: wisata)),
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: _buildWisataImage(wisata),
                        ),
                      ),
                      // Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Penting untuk menghindari overflow
                            children: [
                              Text(
                                wisata['nama'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                wisata['deskripsi'] ?? '-',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  // Helper method untuk menampilkan gambar dengan benar
  Widget _buildWisataImage(Map<String, dynamic> wisata) {
    if (wisata['isCustomImage'] == true) {
      if (kIsWeb) {
        // Untuk web, gunakan Image.memory jika ada data gambar
        if (wisata['webImage'] != null) {
          return Image.memory(
            wisata['webImage'],
            fit: BoxFit.cover,
          );
        }
      } else {
        // Untuk mobile, gunakan Image.file
        return Image.file(
          File(wisata['imagePath']),
          fit: BoxFit.cover,
        );
      }
    }
    
    // Default atau fallback ke asset image
    return Image.asset(
      wisata['imagePath'],
      fit: BoxFit.cover,
    );
  }
}