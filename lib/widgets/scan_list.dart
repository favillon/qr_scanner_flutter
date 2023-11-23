import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';


class ScanList extends StatelessWidget {
  
  final String type;

  const ScanList({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scansList;
    final IconData viewIcon = (type == 'http')  ? Icons.web : Icons.map_outlined;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i ) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red[100],
          child: const Icon(Icons.delete_forever),
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false).deleteForId(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(viewIcon),
          title: Text(scans[i].value),
          subtitle: Text(scans[i].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined),
          onTap: () => launchApplicationForUrl(context , scans[i]),
        ),
      ),
    );
  }
}