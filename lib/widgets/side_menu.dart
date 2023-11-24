import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/setting_page.dart';
import 'package:qr_scanner/share_preferences/preferences.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[

          _DrawerHeader(),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap :() {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap :() {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(context, SettingScreen.routerName);
            },
          )
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  
  AssetImage assetImageBackground = (Preferences.gender == 1) ?
             const AssetImage('assets/background/menu-img.jpg') :
             const AssetImage('assets/background/menu-img-w.png');
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: BoxDecoration(
        image:DecorationImage(
          image : assetImageBackground,
          fit: BoxFit.cover
        )   
      ),
    );
  }
}