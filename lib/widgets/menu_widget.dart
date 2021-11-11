import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu-img.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.pages,
              color: Colors.cyan,
            ),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people_alt,
              color: Colors.cyan,
            ),
            title: Text('Party Mode'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.cyan,
            ),
            title: Text('Configuración'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, 'settings');
              //Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
