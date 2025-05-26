import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_crud/editdata.dart';
import 'package:mysql_crud/tambahdata.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List _listdata = [];
  bool _isloading = true;

  Future _getdata() async {
    try {
      final respone = await http.get(
        Uri.parse('http://192.168.0.116/pember5_mysql/read.php'),
      );
      if (respone.statusCode == 200) {
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print("Terjadi error: $e");
    }
  }

  Future _hapus(String id) async {
    try {
      final respone = await http.post(
        Uri.parse('http://192.168.0.116/pember5_mysql/hapus.php'),
        body: {"id_agenda": id},
      );
      if (respone.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print("Terjadi error: $e");
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "AGENDAKU",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),

      body:
          _isloading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _listdata.length,
                itemBuilder: (context, index) {
                  final item = _listdata[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => EditdataPage(
                                  ListData: {
                                    "id_agenda": _listdata[index]['id_agenda'],
                                    "nama_agenda":
                                        _listdata[index]['nama_agenda'],
                                    "tanggal": _listdata[index]['tanggal'],
                                    "lokasi": _listdata[index]['lokasi'],
                                    "deskripsi": _listdata[index]['deskripsi'],
                                  },
                                ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['nama_agenda'] ?? 'Tanpa Nama',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Tanggal: ${item['tanggal'] ?? '-'}\n'
                                    'Lokasi: ${item['lokasi'] ?? '-'}\n'
                                    'Deskripsi: ${item['deskripsi'] ?? '-'}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      content: Text(
                                        "Anda Yakin Ingin Menghapus Data ? ",
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _hapus(
                                              _listdata[index]['id_agenda'],
                                            ).then((value) {
                                              if (value) {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                    'Data Berhasil Dihapus',
                                                  ),
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(snackBar);
                                              } else {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                    'Data Gagal Dihapus',
                                                  ),
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(snackBar);
                                              }
                                            });
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    ((context) => Homepage()),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                          child: Text("Ya"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Batal"),
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, // Tambahkan ini
        child: Text("+", style: TextStyle(fontSize: 30, color: Colors.white)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Tambahdatapage()),
          );
        },
      ),
    );
  }
}
