// ignore: file_names
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'Medicamentos.dart';
import 'Calendario.dart';
import 'Alarmas.dart';
import 'Recomendaciones.dart';

class Navs extends StatefulWidget {
  const Navs({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavsState createState() => _NavsState();
}

class _NavsState extends State<Navs> {
int _selectedIndex = 0;
static const List<Widget> _pages = <Widget>[
  Home(),
  Camaras(),
  Camaras(),
  Sensores(),
  Home(),
];

final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(title: Text('Agenda'), icon: Icon(Icons.calendar_today_rounded)),
    TitledNavigationBarItem(title: Text('Medicina', style: TextStyle(fontSize: 18), textAlign: TextAlign.center), icon: Icon(Icons.medication)),
    TitledNavigationBarItem(title: Text('Alarmas'), icon: Icon(Icons.alarm_on_rounded)),
    TitledNavigationBarItem(title: Text('Consejos'), icon: Icon(Icons.recommend_rounded)),
    TitledNavigationBarItem(title: Text('Historial'), icon: Icon(Icons.history_rounded)),
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
