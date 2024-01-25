import 'package:restaurant_app/data/model/local_restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDbHelper {
  static FavoriteDbHelper? _favoriteDbHelper;
  static late Database _database;

  FavoriteDbHelper._internal(){
    _favoriteDbHelper = this;
  }

  factory FavoriteDbHelper() => _favoriteDbHelper ?? FavoriteDbHelper._internal();

  Future<Database> get database async{
    _database = await _initializedb();
    return _database;
  }

  static const String _tableName = 'favorites';

  Future<Database> _initializedb() async{
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favorite_db.db'),
      onCreate: (db, version) async{
        await db.execute(
          '''CREATE TABLE $_tableName (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              pictureId TEXT,
              city TEXT,
              rating FLOAT
             )'''
        );
      },
      version: 1
    );
    return db;
  }

  Future<void> insertRestaurantFav(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toJson());
    print('Data saved');
  }

  Future<List<Restaurant>> getRestaurantFav() async{
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    print("--Get all restaurant fav--");
    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Map> getRestaurantFavById(String id) async{
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    print(results);
    if(results.isNotEmpty){
      return results.first;
    }else{
      return {};
    }
  }

  Future<void> updateRestaurantFav(Restaurant restaurant) async{
    final Database db = await database;

    await db.update(
      _tableName, 
      restaurant.toJson(),
      where: 'id = ?',
      whereArgs: [restaurant.id]);
  }

  Future<void> deleteRestaurantFav(String id) async{
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}