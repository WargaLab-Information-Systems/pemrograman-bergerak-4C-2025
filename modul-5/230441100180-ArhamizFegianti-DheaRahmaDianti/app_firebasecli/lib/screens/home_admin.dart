import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/firebase_service.dart';
import 'package:app_firebasecli/form/create_page.dart';
import 'package:app_firebasecli/form/update_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_firebasecli/screens/profile_admin.dart';


class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  late Future<List<Post>> _postList;

  @override
  void initState() {
    super.initState();
    _postList = _firebaseService.getPosts();
  }

  void _refreshPosts() {
    setState(() {
      _postList = _firebaseService.getPosts();
    });
  }

  void _deletePost(String id) async {
    await _firebaseService.deletePost(id);
    _refreshPosts();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produk berhasil dihapus")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bakery Store',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreatePost()),
            );
            _refreshPosts();
          },
        ),
        ],
      ),
      bottomNavigationBar:
        BottomNavigationBar(
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          currentIndex: 0, // Ganti dengan variabel jika navigasi aktif
          onTap: (index) {
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileAdminPage()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart), label: 'Wishlist'),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),
          ],
        ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Post>>(
          future: _postList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Belum ada produk"));
            }

            final posts = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi there!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text('What are you looking for today?'),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.brown[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/logo.jpeg'),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Bakery Store Sidoarjo',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Best Seller This Week',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    itemCount: posts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: File(post.imagePath).existsSync()
                                        ? Image.file(
                                            File(post.imagePath),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          )
                                        : const Icon(Icons.image_not_supported),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post.nama,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Rp ${post.harga}"),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deletePost(post.id!),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => EditPostPage(post: post)),
                                    );
                                    _refreshPosts();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.brown[300],
      //   child: const Icon(Icons.add, color: Colors.black,),
      //   onPressed: () async {
      //     await Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (_) => const CreatePost()),
      //     );
      //     _refreshPosts();
      //   },
      // ),
    );
  }
}
