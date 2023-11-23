import 'package:flutter/material.dart';
import 'package:qr_scanner/widgets/scan_list.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanList(type: 'http');
  }
}