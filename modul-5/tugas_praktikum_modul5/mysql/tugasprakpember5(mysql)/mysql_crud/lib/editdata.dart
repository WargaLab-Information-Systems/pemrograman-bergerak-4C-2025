import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_crud/homepage.dart';

class EditdataPage extends StatefulWidget {
  final Map ListData;
  const EditdataPage({super.key, required this.ListData});

  @override
  State<EditdataPage> createState() => _EditdataPageState();
}

class _EditdataPageState extends State<EditdataPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_agenda = TextEditingController();
  TextEditingController nama_agenda = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController deskripsi = TextEditingController();

  Future _update() async {
    final respone = await http.post(
      Uri.parse('http://192.168.0.116/pember5_mysql/edit.php'),
      body: {
        "id_agenda": id_agenda.text,
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
    id_agenda.text = widget.ListData['id_agenda'];
    nama_agenda.text = widget.ListData['nama_agenda'];
    tanggal.text = widget.ListData['tanggal'];
    lokasi.text = widget.ListData['lokasi'];
    deskripsi.text = widget.ListData['deskripsi'];

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "EDIT AGENDA      ",
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
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
                        return "Nama agenda agenda tidak boleh kosong";
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
                        return "tanggal agenda tidak boleh kosong";
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
                        return "lokasi agenda tidak boleh kosong";
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
                        return "deskripsi agenda tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _update().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data Berhasil Diupdate'),
                            );
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data Gagal Diupdate'),
                            );
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(snackBar);
                          }
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: ((context) => Homepage())),
                          (route) => false,
                        );
                      }
                    },
                    child: Text(
                      "Update",
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
        ),
      ),
    );
  }
}
