import 'package:diabetes_al_dia/Vista/Navegatior/Navs.dart';
import 'package:diabetes_al_dia/Vista/PopMenu/Perfil.dart';
import 'package:diabetes_al_dia/Vista/PopMenu/Setting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bienvenida.dart';
import 'Control/notifi_service.dart';
import 'SplashScreen.dart';
import 'package:timezone/data/latest.dart' as tz;


int? isviewed;
int? wiz;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  wiz = prefs.getInt('wizart');
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => isviewed != 0 ? const Bienvenida() : SplashScreen().animacion(wiz),
        '/splash': (context) => SplashScreen().animacion(wiz),
        '/navs': (context) => const Navs(),
        '/setting': (context) => const Setting(),

      },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        // ignore: avoid_print
        print('Ruta llamado ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext builder) => SplashScreen().animacion(wiz));
      },
    );
  }
}
