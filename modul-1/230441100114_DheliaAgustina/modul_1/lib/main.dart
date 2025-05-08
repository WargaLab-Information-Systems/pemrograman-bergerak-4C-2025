import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Greeting dan avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hi, User",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "image/profil.png"), // contoh avatar
                    radius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Hot Places title
              _buildSectionHeader("Hot Places"),
              const SizedBox(height: 10),

              // Hot Places horizontal list
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                  _buildHotPlaceCard(),
                  _buildHotPlaceCard(),
                  _buildHotPlaceCard(),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Best Hotels title
              _buildSectionHeader("Best Hotels"),
              const SizedBox(height: 10),

              // Best Hotels vertical list
              Column(
                children: List.generate(5, (_) => _buildHotelCard()),
              ),
            ],
          ),
        ),
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

Widget _buildHotPlaceCard() {
  return Container(
    width: 400,
    height: 90,
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
          padding: const EdgeInsets.all(10.0), // jarak 8 di semua sisi
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "image/home.jpg", 
              width: 74, // dikurangi supaya total tetap muat dalam container
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
              children: const [
                Text(
                  "National Park Yosemite",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      "California",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}



  Widget _buildHotelCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        // Tambahkan padding di sekitar gambar
        Padding(
          padding: const EdgeInsets.all(8.0), // Jarak 8 di semua sisi
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12), // sudut gambar melengkung
            child: Image.network(
              "image/home.jpg",
              width: 100, // dikurangi agar tidak overflow setelah ditambah padding
              height: 84,
              fit: BoxFit.cover,
            ),
          ),
        ),
          const SizedBox(width: 12),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "National Park Yosemite",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


