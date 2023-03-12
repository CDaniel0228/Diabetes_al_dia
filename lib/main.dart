import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bienvenida.dart';
import 'SplashScreen.dart';

int? isviewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => isviewed != 0 ? const Bienvenida() : SplashScreen().animacion(),
        '/splash': (context) => SplashScreen().animacion(),
      },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        // ignore: avoid_print
        print('Ruta llamado ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext builder) => SplashScreen().animacion());
      },
    );
  }
}
