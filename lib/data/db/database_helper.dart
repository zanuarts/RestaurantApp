import 'package:restaurant_app/data/models/detail_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
 
  DatabaseHelper._createObject();
 
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }
 
    return _databaseHelper;
  }
 
  static const String _tblFavourite = 'favourites';
 
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurantsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavourite (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating TEXT
           )     
        ''');
      },
      version: 1,
    );
    return db;
  }
 
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
 
    return _database;
  }

  // Metode untuk menyimpan data:
  Future<void> insertFavourite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(_tblFavourite, restaurant.toJson());
  }

  // Mendapatkan seluruh data favourite yang tersimpan:
  Future<List<Restaurant>> getFavourites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblFavourite);
  
    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  // Mencari favourite yang disimpan berdasarkan id.
  Future<Map> getFavouriteById(String id) async {
    final db = await database;
  
    List<Map<String, dynamic>> results = await db.query(
      _tblFavourite,
      where: 'id = ?',
      whereArgs: [id],
    );
  
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  // Menghapus data favourite berdasarkan id.
  Future<void> removeFavourite(String id) async {
    final db = await database;
  
    await db.delete(
      _tblFavourite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}