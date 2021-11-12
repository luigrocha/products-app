import 'package:flutter/material.dart';
import 'package:login/services/services.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
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
              Icons.coffee,
              color: Colors.cyan,
            ),
            title: Text('Productos'),
            onTap: () {
              Navigator.pushNamed(context, 'listProduct');
            },
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
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.cyan,
            ),
            title: Text('Perfil'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, 'perfil');
              //Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.cyan,
            ),
            title: Text('Salir'),
            onTap: () async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
