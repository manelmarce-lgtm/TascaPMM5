import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();

  static Database? _database;

  DBProvider._();

  Future <Database> get database async{
    if(_database != null) return _database = await initDB();
    _database = await initDB();
    return _database!;

  }

  Future<Database> initDB() async {
    //Path de donde se encuentra la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');

    //Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate:(Database db, int version) async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipus TEXT,
            valor TEXT
          )
        ''');
      });
  }

  InserRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipus, valor)
      VALUES ($id, '$tipus', '$valor')
      ''');
      return res;
  }


  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;
    final res = await db.insert('Scans', nouScan.toMap());
    return res;
  }

}