import 'dart:typed_data'; // ini untuk tipe data gambar
import 'package:flutter/material.dart';
import 'form.dart'; // file TambahWisataPage
import 'frame2.dart'; // file DetailPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); 

  @override
  State<HomeScreen> createState() => _HomeScreenState();
} 

class _HomeScreenState extends State<HomeScreen> {
  List<String> hotPlaces = [
    "National Park Yosemite",
    "Grand Canyon",
    "Eiffel Tower",
  ];

  List<Map<String, dynamic>> bestHotels = [
    {
      'nama': 'Hotel California',
      'deskripsi': 'Hotel klasik dengan nuansa vintage.',
      'gambar': null, 
    },
    {
      'nama': 'Marriott Hotel',
      'deskripsi': 'Hotel modern dan nyaman di pusat kota.',
      'gambar': null,
    },
    {
      'nama': 'Hilton',
      'deskripsi': 'Hotel mewah dengan fasilitas lengkap.',
      'gambar': null,
    },
    {
      'nama': 'Holiday Inn',
      'deskripsi': 'Pilihan ekonomis dengan kenyamanan.',
      'gambar': null,
    },
    {
      'nama': 'Radisson Blu',
      'deskripsi': 'Hotel bisnis dengan pelayanan terbaik.',
      'gambar': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Hi, User",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("image/profil.png"),
                    radius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Hot Places Section
              _buildSectionHeader("Hot Places"),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hotPlaces.length,
                  itemBuilder: (context, index) {
                    return _buildHotPlaceCard(hotPlaces[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Best Hotels Section
              _buildSectionHeader("Best Hotels"),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: bestHotels.length,
                  itemBuilder: (context, index) {
                    return _buildHotelCard(context, bestHotels[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF261FB3),
        shape: const CircleBorder(),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahWisataPage()),
          );

          if (result != null && result is Map<String, dynamic>) {
            if (result['namaWisata'] != null && result['deskripsi'] != null) {
              setState(() {
                bestHotels.add({
                  'nama': result['namaWisata'],
                  'deskripsi': result['deskripsi'],
                  'lokasi': result['lokasi'],
                  'kategori': result['kategori'],
                  'gambar': result['imageBytes'],
                });
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data tidak lengkap')),
              );
            }
          }
        },
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          "See All",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildHotPlaceCard(String placeName) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "image/home.jpg",
                width: 74,
                height: 74,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    placeName,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset(
                        "image/pin.png",
                        width: 16,
                        height: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "California",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(BuildContext context, Map<String, dynamic> hotel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              nama: hotel['nama'],
              deskripsi: hotel['deskripsi'],
              lokasi: hotel['lokasi'] ?? 'Lokasi tidak tersedia',
              kategori: hotel['kategori'] ?? 'Kategori tidak tersedia',
              gambar: hotel['gambar'],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: hotel['gambar'] != null
                  ? Image.memory(
                      hotel['gambar'],
                      width: 100,
                      height: 84,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'image/home.jpg', // fallback kalau gambar null
                      width: 100,
                      height: 84,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel['nama'] ?? 'Nama tidak tersedia',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hotel['deskripsi'] ?? 'Deskripsi tidak tersedia',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


