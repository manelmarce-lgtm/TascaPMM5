import 'package:flutter/foundation.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan =  ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if(nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
    }
    return nouScan;
  }
  
  void carregarScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    this.notifyListeners();
  }

  void carregarScansPerTipus(String tipus) async {
    final scans = await DBProvider.db.getScanByTipus(tipus);
    this.scans = [...scans];
    this.tipusSeleccionat = tipus;
    this.notifyListeners();
  }

  void borrarTots() async{
    await DBProvider.db.deleteAllScans();
    this.scans = [];
  }

  void borrarScanPerId(int id) async {
    final eliminat = await DBProvider.db.deleteScan(id);
    if(eliminat > 0) {
      this.scans.removeWhere((scan) => scan.id == id);
      this.notifyListeners();
    }
}
}