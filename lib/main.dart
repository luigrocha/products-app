import 'package:flutter/material.dart';
import 'package:login/screens/screens.dart';
import 'package:login/screens/settings_screen.dart';
import 'package:login/services/services.dart';
import 'package:login/share_prefs/preferencias_usuario.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductsService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CR-Store',
      initialRoute: prefs.ultimaPagina,
      routes: {
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'home': (_) => HomeScreen(),
        'listProduct': (_) => ListProductScreen(),
        'product': (_) => ProductScreen(),
        'checking': (_) => CheckAuthScreen(),
        'settings': (_) => SettingsScreen(),
        'perfil': (_) => UsuarioScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: (prefs.colorSecundario) ? Colors.black87 : Colors.cyan[800],
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor:
                  (prefs.colorSecundario) ? Colors.black87 : Colors.cyan[800],
              elevation: 0)),
    );
  }
}
