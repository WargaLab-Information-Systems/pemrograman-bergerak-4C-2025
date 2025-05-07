import 'package:flutter/material.dart';
import 'detail.dart';
import 'tambah_wisata_page.dart';

void main() {
  runApp(const MyTravelApp());
}

class MyTravelApp extends StatelessWidget {
  const MyTravelApp({super.key});
//menginisialisasi aplikasi Flutter dengan halaman utama (TravelHomePage)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TravelHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TravelHomePage extends StatelessWidget {
  final TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  final TextStyle subtitleStyle = TextStyle(color: Colors.grey[600]);
//membuat baris judul
  Widget sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text("See All", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget hotPlaceCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailPage()),
        );
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                'assets/images/FotoAll.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("National Park",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text("📍 California",
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget hotelCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey.shade200)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/FotoAll.jpg',
                width: 100, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("National Park Yosemite", style: titleStyle),
                const SizedBox(height: 4),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: subtitleStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Hi, User",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/Profile.png"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              sectionTitle("Hot Places"),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    hotPlaceCard(context),
                    hotPlaceCard(context),
                    hotPlaceCard(context),
                    hotPlaceCard(context),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              sectionTitle("Best Hotels"),
              const SizedBox(height: 10),
              hotelCard(),
              hotelCard(),
              hotelCard(),
              hotelCard(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 198, 204, 243),
        child: const Icon(Icons.add, size: 32),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TambahWisataPage()),
          );
        },
      ),
    );
  }
}
