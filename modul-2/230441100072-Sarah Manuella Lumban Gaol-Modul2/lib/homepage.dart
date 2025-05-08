import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wisataalam/main.dart';
import 'package:wisataalam/detailpage.dart';
import 'package:wisataalam/tambahwisata.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPage();
}

class _LayoutPage extends State<LayoutPage> {
  List<Map<String, dynamic>> wisataList = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    Map<String, dynamic> dataAwal = {
      'nama': 'National Park Yosemite',
      'lokasi': 'California',
      'deskripsi':
          'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.',
      'harga': 'Rp 300.000',
      'jenis': 'Wisata Alam',
      'gambar': null,
    };
    wisataList = List.generate(5, (index) => dataAwal);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        title: const Text(
          'Hi, User',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          CircleAvatar(backgroundImage: AssetImage('assets/profil.png')),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SectionTitle(title: 'Hot Places'),
            const SizedBox(height: 8),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: wisataList.length,
                itemBuilder: (context, index) {
                  final item = wisataList[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => DetailPage(
                                  nama: item['nama'],
                                  lokasi: item['lokasi'],
                                  deskripsi: item['deskripsi'],
                                  harga: item['harga'],
                                  jenis: item['jenis'],
                                  gambar: item['gambar'],
                                ),
                          ),
                        );
                      },
                      child: HotPlaceCard(
                        nama: item['nama'],
                        lokasi: item['lokasi'],
                        gambar: item['gambar'],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            const SectionTitle(title: 'Best Hotels'),
            const SizedBox(height: 8),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: wisataList.length,
              itemBuilder: (context, index) {
                final item = wisataList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => DetailPage(
                                nama: item['nama'],
                                lokasi: item['lokasi'],
                                deskripsi: item['deskripsi'],
                                harga: item['harga'],
                                jenis: item['jenis'],
                                gambar: item['gambar'],
                              ),
                        ),
                      );
                    },
                    child: HotelCard(
                      title: item['nama'],
                      deskripsi: item['deskripsi'],
                      gambar: item['gambar'],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 20, 52, 234),
        onPressed: () async {
          final newData = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormPage()),
          );

          if (newData != null && newData['nama'] != null) {
            setState(() {
              wisataList.add(newData);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          'See All',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

class HotPlaceCard extends StatelessWidget {
  final String nama;
  final String lokasi;
  final Uint8List? gambar;

  const HotPlaceCard({
    super.key,
    required this.nama,
    required this.lokasi,
    this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                gambar != null
                    ? Image.memory(
                      gambar!,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    )
                    : Image.asset(
                      'assets/1.jpg',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start, 
              children: [
                Center(
                  child: Text(
                    nama,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        lokasi,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final String title;
  final String deskripsi;
  final Uint8List? gambar;

  const HotelCard({
    super.key,
    required this.title,
    required this.deskripsi,
    this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                gambar != null
                    ? Image.memory(
                      gambar!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    )
                    : Image.asset(
                      'assets/1.jpg',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.justify,

                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  deskripsi,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
