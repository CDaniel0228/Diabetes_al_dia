// ignore: file_names
import 'package:diabetes_al_dia/Control/MedicamentosDB.dart';
import 'package:diabetes_al_dia/Control/Mensajes.dart';
import 'package:diabetes_al_dia/Modelo/medicamentos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'PopMenu.dart';

class Camaras extends StatefulWidget {
  final List<Map<String, dynamic>> inventario;
  Camaras(this.inventario);

  @override
  State<Camaras> createState() => _CamarasState(inventario);
}

class _CamarasState extends State<Camaras> {
  List<Map<String, dynamic>> inventario;
  _CamarasState(this.inventario);
  TextEditingController add = TextEditingController();
  TextEditingController? cont;
  String pathImage = "asset/Farmaco/";
  String? selectedValueSingleMenu;
  List nombres = [];
  int _selectedIndex = -1;
  int contDosisi = 0;
  int contCantidad = 0;
  Color box = Colors.transparent,
      box2 = Colors.transparent,
      box3 = Colors.transparent;
  String tipoMedicina = "asset/Farmaco/capsula.png";
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
      body: new SingleChildScrollView(child: panel()),
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
                    children: [
                      Text("    $contCantidad \t pildora"),
                      btnContador(true)
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text("Dosis"),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent)),
                  child: Row(
                    children: [Text(" $contDosisi  mg"), btnContador(false)],
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Tipo de medicina",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            imageMedicina("Capsulas", "${pathImage}capsula.png", box),
            imageMedicina("Pastillas", "${pathImage}pastilla.png", box2),
            imageMedicina("Inyeccion", "${pathImage}jeringa.png", box3),
          ],
        ),
        const SizedBox(
          height: 70,
        ),
        Center(
            child: Container(
                width: 110,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF11253c)),
                    onPressed: () async {
                      Medicamentos medicamentos = Medicamentos(
                          nombre: add.text,
                          tipo: tipoMedicina,
                          cantidad: contCantidad,
                          dosis: contDosisi);
                      if (await MedicamentosDB().findband(add.text)) {
                        MedicamentosDB().update(medicamentos);
                        Mensajes().info("Se actualizo con exito");
                      } else {
                        MedicamentosDB().crateItem(medicamentos);
                        Mensajes().info("Se guardo con exito");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.add_box_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          "Guardar",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ))))
      ],
    ));
  }

  imageMedicina(nombre, imagen, color) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
            style: TextButton.styleFrom(),
            onPressed: () {
              setState(() {
                switch (nombre) {
                  case "Capsulas":
                    box = Colors.blue;
                    box2 = Colors.transparent;
                    box3 = Colors.transparent;
                    break;
                  case "Pastillas":
                    box = Colors.transparent;
                    box2 = Colors.blue;
                    box3 = Colors.transparent;
                    break;
                  case "Inyeccion":
                    box = Colors.transparent;
                    box2 = Colors.transparent;
                    box3 = Colors.blue;
                    break;
                  default:
                }
                tipoMedicina = imagen;
              });
            },
            child: Column(
              children: [Text(nombre), Image.asset(imagen, height: 50)],
            )));
  }

  btnContador(band) {
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
                  if (band) {
                    contCantidad++;
                  } else {
                    contDosisi++;
                  }
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
                      if (band && contCantidad > 0) {
                        contCantidad--;
                      } else if (!band && contDosisi > 0) {
                        contDosisi--;
                      }
                    });
                  }),
            )
          ],
        ));
  }

  Widget addMedicamentos() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
            child: TextField(
                onChanged: (value) {
                  setState(() {
                    if (value != "") {
                      List<Map<String, dynamic>> medicamentosFiltrados =
                          inventario
                              .where((medicamento) => medicamento["nombre"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                      nombres = medicamentosFiltrados
                          .map((medicamento) => medicamento['nombre'])
                          .toList();
                    } else {
                      nombres = [];
                       box = Colors.transparent;
                      box2 = Colors.transparent;
                      box3 = Colors.transparent;
                    }
                  });
                },
                controller: add,
                enabled: true,
                decoration: decoracionBox("Nombre"))),
        Container(
          height: 100,
          width: 300,
          child: ListView.builder(
            itemCount: nombres.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    add.text = nombres[index];
                    
                      switch (inventario[index]['tipo']) {
                        case "Capsula":
                          box = Colors.blue;
                          box2 = Colors.transparent;
                          box3 = Colors.transparent;
                          break;
                        case "Tableta":
                          box = Colors.transparent;
                          box2 = Colors.blue;
                          box3 = Colors.transparent;
                          break;
                        case "Inyeccion":
                          box = Colors.transparent;
                          box2 = Colors.transparent;
                          box3 = Colors.blue;
                          break;
                        default:
                      break;
                      }
                     
                    //busqueda
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
                      color: _selectedIndex == index ? Colors.white : null,
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
