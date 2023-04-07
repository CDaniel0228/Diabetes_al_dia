import 'package:diabetes_al_dia/Vista/Navegatior/Navs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bienvenida.dart';
import 'Control/notifi_service.dart';
import 'SplashScreen.dart';
import 'package:timezone/data/latest.dart' as tz;


int? isviewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
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
        '/navs': (context) => const Navs(),
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
