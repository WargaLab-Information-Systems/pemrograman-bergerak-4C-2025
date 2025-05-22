
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
import 'package:http/http.dart' as http;
import 'dart:convert';

// Ganti sesuai URL backend PHP kamu
const String baseUrl = 'http://192.168.71.176/pember_modul5'; 

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

  factory LaporanKesehatan.fromJson(Map<String, dynamic> json) {
    return LaporanKesehatan(
      id: json['id'].toString(),
      hari: json['hari'],
      bpm: json['bpm'],
      kalori: json['kalori'],
      langkah: json['langkah'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hari': hari,
      'bpm': bpm,
      'kalori': kalori,
      'langkah': langkah,
    };
  }
}

// API Service
Future<List<LaporanKesehatan>> fetchLaporanKesehatan() async {
  final response = await http.get(Uri.parse('$baseUrl/get.php'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => LaporanKesehatan.fromJson(json)).toList();
  } else {
    throw Exception('Gagal memuat data');
  }
}

Future<void> addLaporan(LaporanKesehatan laporan) async {
  final response = await http.post(
    Uri.parse('$baseUrl/post.php'),
    body: laporan.toJson()..remove('id'),
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal menambahkan data');
  }
}

Future<void> updateLaporan(LaporanKesehatan laporan) async {
  final response = await http.post(
    Uri.parse('$baseUrl/put.php'),
    body: laporan.toJson(),
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal memperbarui data');
  }
}

Future<void> deleteLaporan(String id) async {
  final response = await http.post(
    Uri.parse('$baseUrl/delete.php'),
    body: {'id': id},
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal menghapus data');
  }
}

// UI
class LaporanKesehatanPage extends StatefulWidget {
  @override
  _LaporanKesehatanPageState createState() => _LaporanKesehatanPageState();
}

class _LaporanKesehatanPageState extends State<LaporanKesehatanPage> {
  late Future<List<LaporanKesehatan>> _laporanFuture;

  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _hariController = TextEditingController();
  final _bpmController = TextEditingController();
  final _kaloriController = TextEditingController();
  final _langkahController = TextEditingController();

  String? _editingId;

  void _refreshData() {
    setState(() {
      _laporanFuture = fetchLaporanKesehatan();
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final laporan = LaporanKesehatan(
        id: _editingId ?? '',
        hari: _hariController.text,
        bpm: _bpmController.text,
        kalori: _kaloriController.text,
        langkah: _langkahController.text,
      );

      if (_editingId == null) {
        await addLaporan(laporan);
      } else {
        await updateLaporan(laporan);
        _editingId = null;
      }

      _clearForm();
      _refreshData();
    }
  }

  void _clearForm() {
    _idController.clear();
    _hariController.clear();
    _bpmController.clear();
    _kaloriController.clear();
    _langkahController.clear();
  }

  void _startEdit(LaporanKesehatan laporan) {
    _editingId = laporan.id;
    _idController.text = laporan.id;
    _hariController.text = laporan.hari;
    _bpmController.text = laporan.bpm;
    _kaloriController.text = laporan.kalori;
    _langkahController.text = laporan.langkah;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Laporan Kesehatan")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // FORM
            Padding(
              padding: EdgeInsets.all(16),
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
                      child: Text(_editingId == null ? 'Tambah' : 'Update'),
                    ),
                  ],
                ),
              ),
            ),
            // LIST
            FutureBuilder<List<LaporanKesehatan>>(
              future: _laporanFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final list = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final laporan = list[index];

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(16),
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
                                    await deleteLaporan(laporan.id);
                                    _refreshData();
                                  },
                                ),
                              ],
                            ),
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















