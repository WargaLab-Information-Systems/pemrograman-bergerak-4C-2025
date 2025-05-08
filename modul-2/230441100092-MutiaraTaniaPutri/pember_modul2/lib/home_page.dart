import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'form_page.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> customPlaces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Hi, User", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const CircleAvatar(
                    backgroundImage: AssetImage('image/profil.png'), 
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Hot Places
              _buildSectionHeader("Hot Places"),
              const SizedBox(height: 10),
              _buildHotPlaces(),

              const SizedBox(height: 20),

              // Best Hotels
              _buildSectionHeader("Best Hotels"),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 5 + customPlaces.length,
                  itemBuilder: (context, index) {
                    if (index < 5) {
                      return _buildVerticalCard(context, data);
                    } else {
                      final newPlace = customPlaces[index - 5];
                      return _buildCustomVerticalCard(newPlace);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToFormPage, // pakai fungsi yang kamu buat
        backgroundColor: Colors.blue[800],
        child: Image.asset(
          'image/plusimg.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  void _navigateToFormPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormPage()),
    );

    if (result != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(data: result),
        ),
      );
    }
  }

  Widget _buildCustomVerticalCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.file(
              File(data['image']),
              width: 120,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    data['deskripsi'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  // Hot Places Section
  Widget _buildHotPlaces() {
    final places = List.generate(4, (index) => {
      "title": "National Park Yosemite",
      "location": "California",
    });

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final place = places[index];
          return Container(
            width: 220,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'image/img1.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        place['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            place['location']!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Section Header (Hot Places / Best Hotels)
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text("See All", style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  // Best Hotel Card (Vertical List)
  Widget _buildVerticalCard(BuildContext context,  Map<String, dynamic> data) { 
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(data: data),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.asset(
                'image/img1.jpg',
                width: 120,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("National Park Yosemite", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis...",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
