import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_firebasecli/models/post.dart';

class DatabaseHelper {
  static final DatabaseHelper instance =
      DatabaseHelper._init(); // Singleton instance
  static Database? _database;

  DatabaseHelper._init(); // Private constructor untuk singleton

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_database.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');
  }

  Future<int> registerUser(String email, String password, String role) async {
    final db = await instance.database;
    try {
      int result = await db.insert('users', {
        'email': email,
        'password': password,
        'role': role,
      });
      print("Registrasi berhasil! ID User: $result");
      return result;
    } catch (e) {
      print("Error saat registrasi: $e");
      return 0;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await instance.database; // Gunakan singleton instance
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? result.first : null;
  }
}

class PostHelper {
  static final PostHelper _instance = PostHelper._internal();
  factory PostHelper() => _instance;
  PostHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDb();
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'posts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE posts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imagePath TEXT,
            nama TEXT,
            jenis TEXT,
            harga TEXT,
            deskripsi TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertPost(Post post) async {
    final db = await database;
    return await db.insert('posts', post.toMap());
  }

  Future<List<Post>> getPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('posts');

    return List.generate(maps.length, (i) => Post.fromMap(maps[i]));
  }

  Future<int> updatePost(Post post) async {
    final db = await database;
    return await db.update(
      'posts',
      post.toMap(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  Future<void> deletePost(int id) async {
    final db = await database;
    await db.delete(
      'posts', // nama tabel
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
