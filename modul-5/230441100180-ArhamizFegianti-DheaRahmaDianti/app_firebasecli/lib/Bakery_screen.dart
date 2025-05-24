// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:app_firebasecli/form/update_page.dart';

// class BakeryScreen extends StatefulWidget {
//   const BakeryScreen({super.key});

//   @override
//   State<BakeryScreen> createState() => _BakeryScreenState();
// }

// class _BakeryScreenState extends State<BakeryScreen> {
//   final CollectionReference users = FirebaseFirestore.instance.collection('menu_bakery');

//   final TextEditingController namaController = TextEditingController();
//   final TextEditingController hargaController = TextEditingController();
//   final TextEditingController jenisController = TextEditingController();
//   final TextEditingController deskripsiController = TextEditingController();


//   void _showForm({DocumentSnapshot? doc}) {
//     if (doc != null) {
//       namaController.text = doc['nama'];
//       hargaController.text = doc['harga'];
//       jenisController.text = doc['jenis'];
//     } else {
//       namaController.clear();
//       hargaController.clear();
//       jenisController.clear();
//       deskripsiController.clear();
//     }

//     showModalBottomSheet(
//         backgroundColor: Colors.pink[50],
//         context: context,
//         isScrollControlled: true,
//         builder: (_) => Padding(
//               padding: EdgeInsets.only(
//                   top: 20,
//                   left: 20,
//                   right: 20,
//                   bottom: MediaQuery.of(context).viewInsets.bottom + 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: namaController,
//                     decoration: const InputDecoration(labelText: 'Nama Produk'),
//                   ),
//                   TextField(
//                     controller: jenisController,
//                     decoration: const InputDecoration(labelText: 'Jenis Produk'),
//                   ),
//                   TextField(
//                     controller: hargaController,
//                     decoration: const InputDecoration(labelText: 'Harga Produk'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14)),
//                     ),
//                     child: Text(doc == null ? 'Tambah' : 'Update'),
//                     onPressed: () {
//                       if (doc == null) {
//                         users.add({
//                           'nama': namaController.text,
//                           'jenis': jenisController.text,
//                           'harga': hargaController.text,
//                         });
//                       } else {
//                         users.doc(doc.id).update({
//                           'nama': namaController.text,
//                           'jenis': jenisController.text,
//                           'harga': hargaController.text,
//                         });
//                       }
//                       Navigator.of(context).pop();
//                     },
//                   )
//                 ],
//               ),
//             ));
//   }

//   void _delete(String id) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Konfirmasi Hapus'),
//         content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
//         actions: [
//           TextButton(
//             child: const Text('Batal'),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           ),
//           TextButton(
//             child: const Text('Hapus', style: TextStyle(color: Colors.red)),
//             onPressed: () {
//               users.doc(id).delete();
//               Navigator.of(ctx).pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[50],
//       appBar: AppBar(
//         title: const Text("Profil Pengguna", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.pink,
//       ),
//       body: StreamBuilder(
//         stream: users.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) return Center(child: Text('Terjadi kesalahan.'));
//           if (snapshot.connectionState == ConnectionState.waiting)
//             return Center(child: CircularProgressIndicator());

//           final docs = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final doc = docs[index];
//               return Card(
//                 color: Colors.white,
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: ListTile(
//                   onTap: () => _showForm(doc: doc),
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.pink,
//                     child: Text(
//                       doc['nama'].toString()[0].toUpperCase(),
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   title: Text(doc['nama'], style: TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Text('${doc['jenis']}\n${doc['harga']}\n${doc['deskripsi']}'),
//                   isThreeLine: true,
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.delete_outline_outlined, color: Colors.redAccent),
//                         onPressed: () => _delete(doc.id),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.edit, color: Colors.blue),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => EditProdukPage(doc: doc),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 )

//               );
//             },
//           );
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: Colors.pink,
//       //   child: Icon(Icons.add, color: Colors.white,),
//       //   onPressed: () => _showForm(),
//       // ),
//     );
//   }
// }
