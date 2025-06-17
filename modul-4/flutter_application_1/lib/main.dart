import 'package:flutter/material.dart';
import 'film_model.dart';
import 'film_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Film Bioskop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: FilmListPage(),
    );
  }
}

class FilmListPage extends StatefulWidget {
  @override
  _FilmListPageState createState() => _FilmListPageState();
}

class _FilmListPageState extends State<FilmListPage> {
  List<Film> _filmList = [];
  bool _loading = true;

  final _judulController = TextEditingController();
  final _genreController = TextEditingController();
  final _durasiController = TextEditingController();
  final _jadwalController = TextEditingController();

  Film? _editingFilm;

  @override
  void initState() {
    super.initState();
    _loadFilm();
  }

  Future<void> _loadFilm() async {
    final list = await FilmService.getAllFilm();
    setState(() {
      _filmList = list;
      _loading = false;
    });
  }

  void _showFilmDialog({Film? film}) {
    if (film != null) {
      _editingFilm = film;
      _judulController.text = film.judul;
      _genreController.text = film.genre;
      _durasiController.text = film.durasi;
      _jadwalController.text = film.jadwal;
    } else {
      _editingFilm = null;
      _clearControllers();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(film == null ? 'Tambah Film' : 'Edit Film'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_judulController, 'Judul Film'),
              SizedBox(height: 10),
              _buildTextField(_genreController, 'Genre'),
              SizedBox(height: 10),
              _buildTextField(_durasiController, 'Durasi (menit)', TextInputType.number),
              SizedBox(height: 10),
              _buildTextField(_jadwalController, 'Jadwal Tayang (dd-mm-yyyy hh:mm)'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearControllers();
            },
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newFilm = Film(
                id: film?.id ?? '',
                judul: _judulController.text,
                genre: _genreController.text,
                durasi: _durasiController.text,
                jadwal: _jadwalController.text,
              );

              if (_editingFilm == null) {
                await FilmService.addFilm(newFilm);
              } else {
                await FilmService.updateFilm(newFilm);
              }

              Navigator.pop(context);
              _clearControllers();
              _loadFilm();
            },
            child: Text(film == null ? 'Simpan' : 'Update'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _clearControllers() {
    _judulController.clear();
    _genreController.clear();
    _durasiController.clear();
    _jadwalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Film Bioskop'),
        centerTitle: true,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: _filmList.length,
              itemBuilder: (context, index) {
                final film = _filmList[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      film.judul,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('Genre: ${film.genre}'),
                        Text('Durasi: ${film.durasi} menit'),
                        Text('Jadwal: ${film.jadwal}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showFilmDialog(film: film),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await FilmService.deleteFilm(film.id);
                            _loadFilm();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFilmDialog(),
        icon: Icon(Icons.add),
        label: Text("Tambah Film"),
      ),
    );
  }
}
