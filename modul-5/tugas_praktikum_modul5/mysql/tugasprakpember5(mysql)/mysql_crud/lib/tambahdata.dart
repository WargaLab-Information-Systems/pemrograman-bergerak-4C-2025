import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_crud/homepage.dart';

class Tambahdatapage extends StatefulWidget {
  const Tambahdatapage({super.key});

  @override
  State<Tambahdatapage> createState() => _TambahdatapageState();
}

class _TambahdatapageState extends State<Tambahdatapage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_agenda = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController deskripsi = TextEditingController();

  Future _simpan() async {
    final respone = await http.post(
      Uri.parse('http://192.168.0.116/pember5_mysql/create.php'),
      body: {
        "nama_agenda": nama_agenda.text,
        "tanggal": tanggal.text,
        "lokasi": lokasi.text,
        "deskripsi": deskripsi.text,
      },
    );
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "TAMBAH AGENDA      ",
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
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 15),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: nama_agenda,
                decoration: InputDecoration(
                  hintText: "nama agenda",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama agenda tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: tanggal,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    setState(() {
                      tanggal.text = formattedDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "tanggal",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tanggal tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: lokasi,
                decoration: InputDecoration(
                  hintText: "lokasi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Lokasi tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: deskripsi,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Deskripsi tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _simpan().then((value) {
                      final snackBar = SnackBar(
                        content: Text(
                          value
                              ? 'Data Berhasil Disimpan'
                              : 'Data Gagal Disimpan',
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      if (value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => Homepage()),
                          (route) => false,
                        );
                      }
                    });
                  }
                },
                child: Text(
                  "simpan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
