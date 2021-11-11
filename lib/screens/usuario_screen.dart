import 'package:flutter/material.dart';
import 'package:login/share_prefs/preferencias_usuario.dart';
import 'package:login/widgets/widgets.dart';

class UsuarioScreen extends StatelessWidget {
  static final String routeName = 'home';
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'home';

    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias de Usuario'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Color secundario: ${prefs.colorSecundario}'),
          Divider(),
          Text('Genero: ${prefs.genero}'),
          Divider(),
          Text('Usuario: ${prefs.usuario}'),
          Divider(),
        ],
      ),
    );
  }
}
