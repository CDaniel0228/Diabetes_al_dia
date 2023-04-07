// ignore: file_names
import 'package:diabetes_al_dia/Vista/Navegatior/Historial.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'Medicamentos.dart';
import 'Calendario.dart';
import 'Alrmas.dart';
import 'Recomendaciones.dart';

class Navs extends StatefulWidget {
  const Navs({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavsState createState() => _NavsState();
}

class _NavsState extends State<Navs> {
int _selectedIndex = 0;
static  List<Widget> _pages = <Widget>[
  Home(),
  Camaras(),
  Alarmas(),
  Sensores(),
  Historial(),
];

final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(title: const Text('Agenda', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),icon: Icon(Icons.calendar_today_rounded)),
    TitledNavigationBarItem(title: const Text('Medicina', style: TextStyle(fontSize: 18), textAlign: TextAlign.center), icon: Icon(Icons.medication)),
    TitledNavigationBarItem(title: const Text('Alarmas',style: TextStyle(fontSize: 18), textAlign: TextAlign.center), icon: Icon(Icons.alarm_on_rounded)),
    TitledNavigationBarItem(title: const Text('Consejos', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),icon: Icon(Icons.recommend_rounded)),
    TitledNavigationBarItem(title: const Text('Historial',style: TextStyle(fontSize: 18), textAlign: TextAlign.center), icon: Icon(Icons.history_rounded)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TitledBottomNavigationBar(
        currentIndex: _selectedIndex,
        indicatorHeight: 2,
        onTap: (index) => setState(() {
       _selectedIndex = index;
     }),
        reverse: true,
        curve: Curves.easeInBack,
        items: items,
        activeColor: Colors.red,
        inactiveColor: Colors.blueGrey,
      ),
      body:_pages.elementAt(_selectedIndex),
    );
  }
}
