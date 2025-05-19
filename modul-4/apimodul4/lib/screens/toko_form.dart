import 'package:flutter/material.dart';
import '../models/model.dart';
import '../services/service.dart';

class DoaForm extends StatefulWidget {
  final toko? doa;
  final Function onSave;

  const DoaForm({Key? key, this.doa, required this.onSave}) : super(key: key);

  @override
  _DoaFormState createState() => _DoaFormState();
}

class _DoaFormState extends State<DoaForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.doa != null) {
      _namaProdukController.text = widget.doa!.namaProduk ?? '';
      _hargaController.text = widget.doa!.harga ?? '';
      _kategoriController.text = widget.doa!.kategori ?? '';
    }
  }

  @override
  void dispose() {
    _namaProdukController.dispose();
    _hargaController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final newDoa = toko(
          id: widget.doa?.id,
          namaProduk: _namaProdukController.text,
          harga: _hargaController.text,
          kategori: _kategoriController.text,
        );

        if (widget.doa == null) {
          // Add new data
          await DoaService.addDoa(newDoa);
        } else {
          // Update existing data
          await DoaService.updateDoa(newDoa);
        }

        widget.onSave();
        Navigator.of(context).pop();
      } catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Terjadi Kesalahan'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doa == null ? 'Tambah Data' : 'Edit Data'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _namaProdukController,
                      decoration: InputDecoration(
                        labelText: 'Nama Produk',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama produk tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _hargaController,
                      decoration: InputDecoration(
                        labelText: 'Harga',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harga tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _kategoriController,
                      decoration: InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kategori tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          widget.doa == null ? 'TAMBAH' : 'SIMPAN',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
