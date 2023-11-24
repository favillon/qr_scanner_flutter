import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/theme_provider.dart';
import 'package:qr_scanner/share_preferences/preferences.dart';
import 'package:qr_scanner/widgets/side_menu.dart';

class SettingScreen extends StatefulWidget {

  static const String routerName = 'Settings';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  // bool isDarkmode = true;
  // int gender = 1;
  // String name = 'Nickname';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting')
      ),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ajustes', style: TextStyle( fontSize: 45, fontWeight: FontWeight.w300 )),
            const Divider(),
            SwitchListTile.adaptive(
              value: Preferences.isDarkmode, 
              title: const Text('Darkmode'),
              onChanged: ( value ) {
                
                final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                  
                value 
                  ? themeProvider.setDarkMode() 
                  : themeProvider.setLightMode();
                
                Preferences.isDarkmode = value;
                setState(() {});
              }
            ),
            const Divider(),
            RadioListTile<int>(
              value: 1, 
              groupValue: Preferences.gender, 
              title: const Text('Masculino'),
              onChanged: ( value ) {
                Preferences.gender = value ?? 1;
                setState(() {});
              }
            ),
            const Divider(),
            RadioListTile<int>(
              value: 2, 
              groupValue: Preferences.gender, 
              title: const Text('Femenino'),
              onChanged: ( value ) {
                Preferences.gender = value ?? 2;
                setState(() {});
              }
            ),


            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: TextFormField(
                initialValue: Preferences.name,
                onChanged: ( value ) {
                  Preferences.name = value;
                  setState(() {});
                },
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  helperText: 'Your Nickname'
                ),
              ),
            )

          ]
        )
      ),
    );
  }
}