import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class FirebaseService {
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  // Tambah data ke Firestore
  Future<void> addPost(Post post) async {
    await postsCollection.add(post.toMap());
  }

  // Ambil semua data dari Firestore
  Future<List<Post>> getPosts() async {
    final snapshot = await postsCollection.get();
    return snapshot.docs.map((doc) {
      return Post.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
    }).toList();
  }

  // Update data di Firestore
  Future<void> updatePost(Post post) async {
    if (post.id != null) {
      await postsCollection.doc(post.id).update(post.toMap());
    }
  }

  // Hapus data dari Firestore
  Future<void> deletePost(String id) async {
    await postsCollection.doc(id).delete();
  }
}
