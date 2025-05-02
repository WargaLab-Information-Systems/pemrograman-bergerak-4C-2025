import 'package:flutter/material.dart';
import 'halaman2.dart';
import 'halaman3.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> wisataList = []; 
 // list tambahan dari uploadan baru

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TambahWisataScreen()),
            );

            if (result != null) {
              setState(() {
                wisataList.add(result);
              });
            }
          },
          backgroundColor: const Color(0xFF261FB3),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hi, User',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('images/pp.png'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Title Hot Places
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hot Places',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // List horizontal Hot Places
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'images/pemandangan.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'National Park Yosemite',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'images/lokasi.png',
                                        width: 16,
                                        height: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'California',
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Title Best Hotels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Best Hotels',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // List vertikal Best Hotels
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < 5; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              wisata: {
                                'nama': 'National Park Yosemite',
                                'deskripsi': 'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.',
                                'gambar': null,
                                'lokasi': 'California',
                                'kategori': 'Wisata Alam',
                                'harga': '30.000,00',
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'images/pemandangan.jpg',
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'National Park Yosemite',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis, doloribus. Eos, accusantium doloremque! Tenetur, sed.',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Tambahan wisata dari upload user
                    for (var wisata in wisataList)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(wisata: wisata),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(
                                wisata['gambar'],
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    wisata['nama'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    wisata['deskripsi'],
                                    style: const TextStyle(fontSize: 13),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
}

