
// // laporan_kesehatan.dart

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // Model untuk data laporan kesehatan
// class LaporanKesehatan {
//   final String id;
//   final String hari;
//   final String bpm;
//   final String kalori;
//   final String langkah;

//   LaporanKesehatan({
//     required this.id,
//     required this.hari,
//     required this.bpm,
//     required this.kalori,
//     required this.langkah,
//   });

//   factory LaporanKesehatan.fromJson(Map<String, dynamic> json) {
//     return LaporanKesehatan(
//       id: json['id_laporan'],
//       hari: json['hari'],
//       bpm: json['BPM'],
//       kalori: json['kalori'],
//       langkah: json['langkah'],
//     );
//   }
// }

// // Fungsi untuk ambil data dari API
// Future<List<LaporanKesehatan>> fetchLaporanKesehatan() async {
//   final response = await http.get(Uri.parse(
//       'https://api-dhelia-default-rtdb.firebaseio.com/laporan_kesehatan.json'));

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = json.decode(response.body);
//     final List<dynamic> rawList = data.values.first;

//     // Hilangkan elemen pertama (null)
//     final cleanedList = rawList.where((e) => e != null).toList();

//     return cleanedList
//         .map((e) => LaporanKesehatan.fromJson(e as Map<String, dynamic>))
//         .toList();
//   } else {
//     throw Exception('Gagal memuat data dari API');
//   }
// }

// // Halaman utama laporan kesehatan
// class LaporanKesehatanPage extends StatefulWidget {
//   @override
//   _LaporanKesehatanPageState createState() => _LaporanKesehatanPageState();
// }

// class _LaporanKesehatanPageState extends State<LaporanKesehatanPage> {
//   late Future<List<LaporanKesehatan>> _laporanFuture;

//   @override
//   void initState() {
//     super.initState();
//     _laporanFuture = fetchLaporanKesehatan();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Laporan Kesehatan")),
//       body: FutureBuilder<List<LaporanKesehatan>>(
//         future: _laporanFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('Tidak ada data tersedia'));
//           }

//           final laporanList = snapshot.data!;

//           return ListView.builder(
//             itemCount: laporanList.length,
//             itemBuilder: (context, index) {
//               final laporan = laporanList[index];
//               return Card(
//                 margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 elevation: 3,
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Hari: ${laporan.hari}",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 6),
//                       Text("BPM: ${laporan.bpm}"),
//                       Text("Kalori: ${laporan.kalori}"),
//                       Text("Langkah: ${laporan.langkah}"),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // Model
// class LaporanKesehatan {
//   final String id;
//   final String hari;
//   final String bpm;
//   final String kalori;
//   final String langkah;

//   LaporanKesehatan({
//     required this.id,
//     required this.hari,
//     required this.bpm,
//     required this.kalori,
//     required this.langkah,
//   });

//   factory LaporanKesehatan.fromJson(Map<String, dynamic> json) {
//     return LaporanKesehatan(
//       id: json['id_laporan'],
//       hari: json['hari'],
//       bpm: json['BPM'],
//       kalori: json['kalori'],
//       langkah: json['langkah'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id_laporan': id,
//       'hari': hari,
//       'BPM': bpm,
//       'kalori': kalori,
//       'langkah': langkah,
//     };
//   }
// }

// // Fungsi API
// const String baseUrl = 'https://api-dhelia-default-rtdb.firebaseio.com/laporan_kesehatan';
// const String keyNode = '-OPg7lmnAmRIxAM-L0xJ';

// Future<List<LaporanKesehatan>> fetchLaporanKesehatan() async {
//   final response = await http.get(Uri.parse('$baseUrl/$keyNode.json'));

//   if (response.statusCode == 200) {
//     final List<dynamic> rawList = json.decode(response.body);

//     final cleanedList = rawList.where((e) => e != null).toList();

//     return cleanedList
//         .map((e) => LaporanKesehatan.fromJson(e as Map<String, dynamic>))
//         .toList();
//   } else {
//     throw Exception('Gagal memuat data');
//   }
// }

// Future<void> addLaporan(LaporanKesehatan laporan) async {
//   final response = await http.get(Uri.parse('$baseUrl/$keyNode.json'));
//   List<dynamic> existing = [];

//   if (response.statusCode == 200) {
//     existing = json.decode(response.body);
//   }

//   existing.add(laporan.toJson());

//   await http.put(Uri.parse('$baseUrl/$keyNode.json'),
//       body: json.encode(existing));
// }

// Future<void> updateLaporan(int index, LaporanKesehatan laporan) async {
//   final response = await http.get(Uri.parse('$baseUrl/$keyNode.json'));
//   List<dynamic> data = json.decode(response.body);

//   data[index] = laporan.toJson();

//   await http.put(Uri.parse('$baseUrl/$keyNode.json'),
//       body: json.encode(data));
// }

// Future<void> deleteLaporan(int index) async {
//   final response = await http.get(Uri.parse('$baseUrl/$keyNode.json'));
//   List<dynamic> data = json.decode(response.body);

//   data.removeAt(index);

//   await http.put(Uri.parse('$baseUrl/$keyNode.json'),
//       body: json.encode(data));
// }

// // UI Page
// class LaporanKesehatanPage extends StatefulWidget {
//   @override
//   _LaporanKesehatanPageState createState() => _LaporanKesehatanPageState();
// }

// class _LaporanKesehatanPageState extends State<LaporanKesehatanPage> {
//   late Future<List<LaporanKesehatan>> _laporanFuture;

//   final _formKey = GlobalKey<FormState>();
//   final _idController = TextEditingController();
//   final _hariController = TextEditingController();
//   final _bpmController = TextEditingController();
//   final _kaloriController = TextEditingController();
//   final _langkahController = TextEditingController();

//   int? _editingIndex;

//   void _refreshData() {
//     setState(() {
//       _laporanFuture = fetchLaporanKesehatan();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _laporanFuture = fetchLaporanKesehatan();
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       final laporan = LaporanKesehatan(
//         id: _idController.text,
//         hari: _hariController.text,
//         bpm: _bpmController.text,
//         kalori: _kaloriController.text,
//         langkah: _langkahController.text,
//       );

//       if (_editingIndex == null) {
//         await addLaporan(laporan);
//       } else {
//         await updateLaporan(_editingIndex!, laporan);
//         _editingIndex = null;
//       }

//       _clearForm();
//       _refreshData();
//     }
//   }

//   void _clearForm() {
//     _idController.clear();
//     _hariController.clear();
//     _bpmController.clear();
//     _kaloriController.clear();
//     _langkahController.clear();
//   }

//   void _startEdit(int index, LaporanKesehatan laporan) {
//     _idController.text = laporan.id;
//     _hariController.text = laporan.hari;
//     _bpmController.text = laporan.bpm;
//     _kaloriController.text = laporan.kalori;
//     _langkahController.text = laporan.langkah;
//     _editingIndex = index;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Laporan Kesehatan")),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // FORM INPUT
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _idController,
//                       decoration: InputDecoration(labelText: 'ID Laporan'),
//                       validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _hariController,
//                       decoration: InputDecoration(labelText: 'Hari'),
//                       validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _bpmController,
//                       decoration: InputDecoration(labelText: 'BPM'),
//                       validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _kaloriController,
//                       decoration: InputDecoration(labelText: 'Kalori'),
//                       validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _langkahController,
//                       decoration: InputDecoration(labelText: 'Langkah'),
//                       validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
//                     ),
//                     SizedBox(height: 12),
//                     ElevatedButton(
//                       onPressed: _submitForm,
//                       child: Text(_editingIndex == null ? 'Tambah' : 'Update'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // LIST DATA
//             FutureBuilder<List<LaporanKesehatan>>(
//               future: _laporanFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }

//                 final laporanList = snapshot.data!;

//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: laporanList.length,
//                   itemBuilder: (context, index) {
//                     final laporan = laporanList[index];

//                     return Card(
//                       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       child: Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Hari: ${laporan.hari}",
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             Text("BPM: ${laporan.bpm}"),
//                             Text("Kalori: ${laporan.kalori}"),
//                             Text("Langkah: ${laporan.langkah}"),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.edit),
//                                   onPressed: () => _startEdit(index, laporan),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.delete),
//                                   onPressed: () async {
//                                     await deleteLaporan(index);
//                                     _refreshData();
//                                   },
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// Model
class LaporanKesehatan {
  final String id;
  final String hari;
  final String bpm;
  final String kalori;
  final String langkah;

  LaporanKesehatan({
    required this.id,
    required this.hari,
    required this.bpm,
    required this.kalori,
    required this.langkah,
  });

 

  factory LaporanKesehatan.fromDocument(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;
  return LaporanKesehatan(
    id: doc.id,
    hari: data['hari'] ?? '',
    bpm: data['BPM'].toString(),
    kalori: data['kalori'].toString(),
    langkah: data['langkah'].toString(),
  );
}


  Map<String, dynamic> toMap() {
    return {
      'hari': hari,
      'BPM': bpm,
      'kalori': kalori,
      'langkah': langkah,
    };
  }
}

// UI Page
class LaporanKesehatanPage extends StatefulWidget {
  @override
  _LaporanKesehatanPageState createState() => _LaporanKesehatanPageState();
}

class _LaporanKesehatanPageState extends State<LaporanKesehatanPage> {
  final _formKey = GlobalKey<FormState>();
  final _hariController = TextEditingController();
  final _bpmController = TextEditingController();
  final _kaloriController = TextEditingController();
  final _langkahController = TextEditingController();

  String? _editingDocId;

  CollectionReference laporanRef =
      FirebaseFirestore.instance.collection('Laporan_kesehatan');

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'hari': _hariController.text,
        'BPM': _bpmController.text,
        'kalori': _kaloriController.text,
        'langkah': _langkahController.text,
      };

      if (_editingDocId == null) {
        await laporanRef.add(data);
      } else {
        await laporanRef.doc(_editingDocId).update(data);
        _editingDocId = null;
      }

      _clearForm();
      setState(() {}); // Refresh UI
    }
  }

  void _clearForm() {
    _hariController.clear();
    _bpmController.clear();
    _kaloriController.clear();
    _langkahController.clear();
    _editingDocId = null;
  }

  void _startEdit(LaporanKesehatan laporan) {
    _hariController.text = laporan.hari;
    _bpmController.text = laporan.bpm;
    _kaloriController.text = laporan.kalori;
    _langkahController.text = laporan.langkah;
    _editingDocId = laporan.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laporan Kesehatan')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // FORM
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _hariController,
                      decoration: InputDecoration(labelText: 'Hari'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _bpmController,
                      decoration: InputDecoration(labelText: 'BPM'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _kaloriController,
                      decoration: InputDecoration(labelText: 'Kalori'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _langkahController,
                      decoration: InputDecoration(labelText: 'Langkah'),
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child:
                          Text(_editingDocId == null ? 'Tambah' : 'Update'),
                    ),
                  ],
                ),
              ),
            ),
            // LIST
            StreamBuilder<QuerySnapshot>(
              stream: laporanRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Firestore Error: ${snapshot.error}');
                  return Text('Terjadi error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final docs = snapshot.data!.docs;
                final laporanList = docs
                    .map((doc) => LaporanKesehatan.fromDocument(doc))
                    .toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: laporanList.length,
                  itemBuilder: (context, index) {
                    final laporan = laporanList[index];

                    return Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hari: ${laporan.hari}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("BPM: ${laporan.bpm}"),
                            Text("Kalori: ${laporan.kalori}"),
                            Text("Langkah: ${laporan.langkah}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _startEdit(laporan),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await laporanRef
                                        .doc(laporan.id)
                                        .delete();
                                    setState(() {}); // Refresh
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
