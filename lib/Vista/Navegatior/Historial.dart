// ignore: file_names
import 'package:flutter/material.dart';

import 'PopMenu.dart';

class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  bool band = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calendario"),
          centerTitle: true,
          backgroundColor: Color(0xFF11253c),
          automaticallyImplyLeading: false,
          actions: [PopMenu().menu(context)],
        ),
        body: Center(
          child: panel(),
        ));
  }

  Widget panel() {
    return Container(
        child: Column(
      children: [
        Text("Mis medicamentos"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [dia("1"), dia("2"),dia("3"), dia("4"),dia("5"), dia("6"), dia("7")],
        ),
        Text("Hoy"),
        lista(),
      ],
    ));
  }

  Widget dia(numero) {
    return Container(
      width: 50,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Text(numero),
    );
  }

  Widget lista() {
    return Container(
        width: 350,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          Image.asset("asset/insulina.png"),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text("Insulina",
                  style: TextStyle(
                    fontSize: 15,
                  )),
              Text("1 inyeccion [18 mg]")
            ],
          )
        ]));
  }
}
