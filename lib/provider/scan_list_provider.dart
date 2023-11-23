import 'package:flutter/material.dart';
import 'package:qr_scanner/provider/db_provider.dart';


class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scansList = []; 
  String typeSelected = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.insertScan(newScan);

    newScan.id = id;

    if (typeSelected == newScan.type) {
      scansList.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async{
    final scans = await DBProvider.db.getAllScan();
    scansList = [...scans!];
    notifyListeners();
  }

  loadScansType(String type) async{
    final scans = await DBProvider.db.getScanType(type);
    scansList = [...scans!];
    typeSelected = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    scansList = [];
    notifyListeners();
  }

  deleteForId(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}