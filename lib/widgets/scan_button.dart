import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class ScanButtom extends StatelessWidget {
  const ScanButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed:() async{
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF', 
          'Cancelar', 
          false, 
          ScanMode.QR
        );
        //String barcodeScanRes = 'https://cepam.com.co';
        //String barcodeScanRes = 'geo:-38.37611542403603,-66.25854492187501';
        if (barcodeScanRes == '-1') {
          return;
        }
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanListProvider.newScan(barcodeScanRes);
        launchApplicationForUrl(context, newScan);
      },
    );
  }
}