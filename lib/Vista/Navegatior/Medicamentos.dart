// ignore: file_names
import 'package:flutter/material.dart';

import 'PopMenu.dart';

class Camaras extends StatelessWidget {
  TextEditingController? add;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicamentos"),
        backgroundColor: Color(0xFF11253c),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [PopMenu().menu(context)],
      ),
      body: panel(),
    );
  }

  Widget panel() {
    return Container(
        child: Column(
      children: [
        Text("Agregar medicamentos"),
        addMedicamentos(),
        Row(
          children: [
            Column(
              children: [Text("Cantidad")],
            ),
            Column(
              children: [Text("Dosis")],
            ),
          ],
        ),
        Text("Tipo de medicina"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            tipoMedicina("asset/capsula.png", "f"),
            tipoMedicina("asset/pastilla.png", "f"),
            tipoMedicina("asset/insulina.png", "f")
          ],
        )
      ],
    ));
  }

  Widget tipoMedicina(imagen, nombre) {
    return Container(
      child: Column(
        children: [Image.asset(imagen, height: 50), Text(nombre)],
      ),
    );
  }

  Widget addMedicamentos() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: add,
            enabled: true,
            decoration: decoracionBox("Nombre")));
  }

  decoracionBox(nombre) {
    return InputDecoration(
        labelText: nombre,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
