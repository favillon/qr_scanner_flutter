import 'package:flutter/material.dart';
import 'package:qr_scanner/provider/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void launchApplicationForUrl(BuildContext context, ScanModel scan) async {
  final Uri url = Uri.parse(scan.value);

  if (scan.type == 'http') {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(context, 'maps', arguments: scan);
  }
}