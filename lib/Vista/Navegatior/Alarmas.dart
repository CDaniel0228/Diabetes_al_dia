// ignore: file_names
import 'package:flutter/material.dart';

import '../../Constantes.dart';
import 'PopMenu.dart';

class Iluminacion extends StatefulWidget {
  const Iluminacion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IluminacionState createState() => _IluminacionState();
}

class _IluminacionState extends State<Iluminacion> {
  String cambioImagen = '';
  String habitacion = 'bienvenida.jpg';
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarmas"),
        centerTitle: true,
        backgroundColor: Color(0xFF11253c),
        automaticallyImplyLeading: false,
        actions: [PopMenu().menu(context)],
      ),
      body: panel(),
    );
  }

  Widget panel() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top:10, left: 10),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain, image: AssetImage(habitacion)),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Color(0xFF69789b)),
        ),
        Switch(
            value: isSwitched,
            activeColor: Color(0xFF69789b),
            onChanged: (value) {
              if (!isSwitched) {
                cambioImagen = 'bienvenida.jpg';
              } else {
                cambioImagen = 'bienvenida.jpg';
              }
              setState(() {
                habitacion = cambioImagen;
                isSwitched = value;
              });
            })
      ],
    );
  }
}
