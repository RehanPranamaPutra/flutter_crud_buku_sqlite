import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_buku_flutter/model/model_buku.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'db_buku');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tb_buku (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judulBuku TEXT,
        kategori TEXT
      )
    ''');
  }

  Future<int> insertBuku(ModelBuku buku) async {
    Database db = await instance.db;
    return await db.insert('tb_buku', buku.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllBuku() async {
    Database db = await instance.db;
    return await db.query('tb_buku');
  }

  Future<int> updateBuku(ModelBuku buku) async {
    Database db = await instance.db;
    return await db.update('tb_buku', buku.toMap(), where: 'id = ?', whereArgs: [buku.id]);
  }

  Future<int> deleteBuku(int id) async {
    Database db = await instance.db;
    return await db.delete('tb_buku', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> dummyBuku() async {
    final existingData = await queryAllBuku();
    if (existingData.isNotEmpty) return; // Cegah data ganda

    List<ModelBuku> dataBukuToAdd = [
      ModelBuku(judulBuku: 'Hii Miko', kategori: 'Komik'),
      ModelBuku(judulBuku: 'Scrambled', kategori: 'Komik'),
      ModelBuku(judulBuku: 'Raden Ajeng Kartini', kategori: 'Novel'),
      ModelBuku(judulBuku: 'Untukmu anak bungsu', kategori: 'Psikolog'),
      ModelBuku(judulBuku: 'Hujan Reda', kategori: 'Novel'),
    ];

    for (ModelBuku modelBuku in dataBukuToAdd) {
      await insertBuku(modelBuku);
    }
  }
}
