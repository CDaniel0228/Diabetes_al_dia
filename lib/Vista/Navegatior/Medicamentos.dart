// ignore: file_names
import 'package:diabetes_al_dia/Modelo/medicamentos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'PopMenu.dart';

class Camaras extends StatefulWidget {
  final List<Map<String, dynamic>> medicamentos;
  Camaras(this.medicamentos);

  @override
  State<Camaras> createState() => _CamarasState(medicamentos);
}

class _CamarasState extends State<Camaras> {
  List<Map<String, dynamic>> medicamentos;
  _CamarasState(this.medicamentos);
  List<Medicamentos> productos = [];
  TextEditingController add=TextEditingController();
  TextEditingController?  cont;
  String pathImage = "asset/Farmaco/";
  String? selectedValueSingleMenu;
  List nombres = [];
  int _selectedIndex = -1;
  int contador = 0;
  @override
  Widget build(BuildContext context) {
    print("object");
    print(medicamentos.length);
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
        const Text("Agregar medicamentos"),
        addMedicamentos(),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text("Cantidad"),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent)),
                  child: Row(
                    children: [Text("    $contador \t pildora"), btnContador()],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text("Tiempo"),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent)),
                  child: Row(
                    children: [Text(" $contador  semanas"), btnContador()],
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Tipo de medicina",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Capsulas"),
                tipoMedicina("${pathImage}capsula.png", "f")
              ],
            ),
            Column(
              children: [
                Text("Pastillas"),
                tipoMedicina("${pathImage}pastilla.png", "f")
              ],
            ),
            Column(
              children: [
                Text("Inyeccion"),
                tipoMedicina("${pathImage}jeringa.png", "f")
              ],
            )
          ],
        ),
        ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [Icon(Icons.add_box_rounded), Text("Guardar")],
            )),
        TextButton(
            onPressed: () {},
            child: Row(
              children: [Icon(Icons.add_box_rounded), Text("Guardar")],
            ))
      ],
    ));
  }

  btnContador() {
    return Container(
        width: 40,
        height: 40,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Expanded(
                child: InkWell(
              child: const Icon(
                Icons.arrow_drop_up,
                size: 25,
              ),
              onTap: () {
                setState(() {
                  contador++;
                });
              },
            )),
            SizedBox(
              height: 2,
            ),
            Expanded(
              child: InkWell(
                  child: const Icon(Icons.arrow_drop_down, size: 25),
                  onTap: () {
                    setState(() {
                      contador--;
                    });
                  }),
            )
          ],
        ));
  }

  tipoMedicina(imagen, nombre) {
    return Container(
      child: Column(
        children: [Image.asset(imagen, height: 50), Text(nombre)],
      ),
    );
  }

  Widget addMedicamentos() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
            child: TextField(
                
                onChanged: (value) {
                  setState(() {
                    List<Map<String, dynamic>> medicamentosFiltrados =
                        medicamentos
                            .where((medicamento) => medicamento["nombre"]
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                    nombres = medicamentosFiltrados
                        .map((medicamento) => medicamento['nombre'])
                        .toList();
                    print(nombres);
                  });
                },
                controller: add,
                enabled: true,
                decoration: decoracionBox("Nombre"))),
        Container(
          height: 100,
          width: 150,
          child: ListView.builder(
            itemCount: nombres.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    add.text=nombres[index];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: _selectedIndex == index ? Colors.blue : null,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    nombres[index],
                    style: TextStyle(
                      color: _selectedIndex == index ? Colors.black : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  decoracionBox(nombre) {
    return InputDecoration(
        labelText: nombre,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
