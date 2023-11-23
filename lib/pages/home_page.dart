import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:qr_scanner/pages/address_page.dart';
import 'package:qr_scanner/pages/maps_page.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/provider/ui_provider.dart';
import 'package:qr_scanner/widgets/custom_navigator_bar.dart';
import 'package:qr_scanner/widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(onPressed:() {
            Provider.of<ScanListProvider>(context, listen: false).deleteAll();
          }, 
          icon: const Icon(Icons.delete_forever_outlined))
        ],
      ),
      body: _HomeBody(),
      bottomNavigationBar:  const CustomNavigationBar(),
      floatingActionButton: const ScanButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    // Read DB
    //DBProvider.db.database;
    //final tempScan = ScanModel(value: 'http://google.com/');
    //DBProvider.db.insertScan(tempScan);
    //DBProvider.db.getAllScan().then(print);
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
    
    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansType('geo');
        return const MapsPage() ;
      case 1:
        scanListProvider.loadScansType('http');
        return const AddressPage() ;
      default:
        return const MapsPage() ;
    }
  }
}