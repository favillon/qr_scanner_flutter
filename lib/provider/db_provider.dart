
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_scanner/models/scan_model.dart';
export 'package:qr_scanner/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();
  
  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {

    Directory documentsDirectory =  await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        
        await db.execute('''
            CREATE TABLE scans(
              id INTEGER PRIMARY KEY,
              type TEXT,
              value TEXT
            )
          ''',
        );

      }
    );
  }

  Future<int> insertScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('scans', newScan.toJson());
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('scans', where: 'id = ?', whereArgs: [id]);
    
    return res.isNotEmpty 
      ? ScanModel?.fromJson(res.first) 
      : null;
  }

  Future<List<ScanModel>?> getAllScan() async {
    final db = await database;
    final res = await db.query('scans');
    
    return res.isNotEmpty 
      ? res.map( (scan) => ScanModel.fromJson(scan) ).toList()
      : [];
  }
  Future<List<ScanModel>?> getScanType(String type) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT 
        *
      FROM
        scans
      WHERE
        type = '$type'
    ''');
    
    return res.isNotEmpty 
      ? res.map( (scan) => ScanModel.fromJson(scan) ).toList()
      : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('scans', newScan.toJson(), where:  'id = ?', whereArgs: [newScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('scans', where:  'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('scans');
    return res;
  }
}