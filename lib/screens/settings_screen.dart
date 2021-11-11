import 'package:flutter/material.dart';
import 'package:login/share_prefs/preferencias_usuario.dart';
import 'package:login/widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  late bool _colorSecundario;
  late int _genero;

  late TextEditingController _textEditingController;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = SettingsScreen.routeName;
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textEditingController = new TextEditingController(text: prefs.usuario);
  }

  _setSelectedRadio(int valor) {
    prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajustes'),
          backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
        ),
        drawer: MenuWidget(),
        body: Center(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            SwitchListTile(
                value: _colorSecundario,
                title: Text('Color secundario'),
                onChanged: (value) {
                  _colorSecundario = value;
                  prefs.colorSecundario = value;

                  setState(() {});
                }),
            RadioListTile(
              title: Text('Masculino'),
              value: 1,
              groupValue: _genero,
              onChanged: _setSelectedRadio(_genero),
            ),
            RadioListTile(
              title: Text('Femenino'),
              value: 2,
              groupValue: _genero,
              onChanged: _setSelectedRadio(_genero),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Nombre de la persona que usa el teléfono',
                ),
                onChanged: (value) {
                  prefs.usuario = value;
                },
              ),
            )
          ],
        )));
  }
}
