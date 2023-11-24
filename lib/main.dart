import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_scanner/pages/home_page.dart';
import 'package:qr_scanner/pages/map_page.dart';
import 'package:qr_scanner/pages/setting_page.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/provider/theme_provider.dart';
import 'package:qr_scanner/provider/ui_provider.dart';
import 'package:qr_scanner/share_preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode)),
      ],
    child:  const QrScanner()
    )
  );
}

class QrScanner extends StatelessWidget {
  const QrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'maps': (_) => const MapScreen(),
        SettingScreen.routerName: (_) => const SettingScreen()
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}