import 'package:flutter/material.dart';
import 'film_model.dart';
import 'film_service.dart';

class FilmListScreen extends StatefulWidget {
  @override
  _FilmListScreenState createState() => _FilmListScreenState();
}

class _FilmListScreenState extends State<FilmListScreen> {
  List<Film> _films = [];

  @override
  void initState() {
    super.initState();
    fetchFilm();
  }

  void fetchFilm() async {
    final data = await FilmService.getAllFilm();
    setState(() {
      _films = data;
    });
  }

  void deleteFilm(String id) async {
    await FilmService.deleteFilm(id);
    fetchFilm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Film Bioskop")),
      body: ListView.builder(
        itemCount: _films.length,
        itemBuilder: (context, index) {
          final film = _films[index];
          return ListTile(
            title: Text(film.judul),
            subtitle: Text("${film.genre} • ${film.durasi} menit"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteFilm(film.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: fetchFilm,
      ),
    );
  }
}
