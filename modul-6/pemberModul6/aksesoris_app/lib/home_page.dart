import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Model Aksesoris sederhana
class Aksesoris {
  int id;
  String nama;
  int stok;
  int harga;

  Aksesoris({
    required this.id,
    required this.nama,
    required this.stok,
    required this.harga,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Aksesoris> aksesorisList = [];

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Position? _currentPosition;

  int _nextId = 1;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _getCurrentLocation();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permission ditolak
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
    });

    _showNotification(position);
  }

  Future<void> _showNotification(Position position) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'lokasi_channel',
      'Lokasi',
      channelDescription: 'Notifikasi lokasi terkini',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0,
      'Lokasi Kamu',
      'Lat: ${position.latitude}, Long: ${position.longitude}',
      platformChannelSpecifics,
      payload: 'Lokasi terkini',
    );
  }

  void _tambahData() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(),
      ),
    );

    if (result != null && result is Aksesoris) {
      setState(() {
        result.id = _nextId++;
        aksesorisList.add(result);
      });
    }
  }

  void _editData(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(
          aksesoris: aksesorisList[index],
        ),
      ),
    );

    if (result != null && result is Aksesoris) {
      setState(() {
        aksesorisList[index] = result;
      });
    }
  }

  void _hapusData(int index) {
    setState(() {
      aksesorisList.removeAt(index);
    });
  }

  Widget _buildItem(Aksesoris aksesoris, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(aksesoris.nama),
        subtitle: Text('Stok: ${aksesoris.stok}, Harga: Rp${aksesoris.harga}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editData(index),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _hapusData(index),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Aksesoris'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              _currentPosition == null
                  ? 'Mendapatkan lokasi...'
                  : 'Lat: ${_currentPosition!.latitude.toStringAsFixed(5)}, Long: ${_currentPosition!.longitude.toStringAsFixed(5)}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ),
      ),
      body: aksesorisList.isEmpty
          ? const Center(child: Text('Belum ada data aksesoris'))
          : ListView.builder(
              itemCount: aksesorisList.length,
              itemBuilder: (context, index) {
                return _buildItem(aksesorisList[index], index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahData,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Halaman Form Tambah/Edit Aksesoris
class FormPage extends StatefulWidget {
  final Aksesoris? aksesoris;
  const FormPage({Key? key, this.aksesoris}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _stokController;
  late TextEditingController _hargaController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.aksesoris?.nama ?? '');
    _stokController =
        TextEditingController(text: widget.aksesoris?.stok.toString() ?? '');
    _hargaController =
        TextEditingController(text: widget.aksesoris?.harga.toString() ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _stokController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final aksesoris = Aksesoris(
        id: widget.aksesoris?.id ?? 0,
        nama: _namaController.text,
        stok: int.parse(_stokController.text),
        harga: int.parse(_hargaController.text),
      );

      Navigator.pop(context, aksesoris);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.aksesoris == null ? 'Tambah Aksesoris' : 'Edit Aksesoris'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Aksesoris'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stokController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Stok harus angka dan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hargaController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Harga harus angka dan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simpan,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
