// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_choices/search_choices.dart';

import 'PopMenu.dart';

class Camaras extends StatefulWidget {
  const Camaras({super.key});

  @override
  State<Camaras> createState() => _CamarasState();
}

class _CamarasState extends State<Camaras> {
  TextEditingController? add, cont;
  String pathImage = "asset/Farmaco/";
  int contador = 0;
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
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Cantidad"),

                //mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,

                /*Container(
                      height: 30,
                      width: 80,
                      child: TextFormField(
                        controller: cont,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),*/
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
        SizedBox(
          height: 20,
        ),
        Text(
          "Tipo de medicina",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
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
                Text("Injeccion"),
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

  /*buscaFiltra(){
    return SearchChoices.single(
        items: items,
        value: selectedValueSingleMenu,
        hint: "Select one",
        searchHint: null,
        onChanged: (value) {
          setState(() {
            selectedValueSingleMenu = value;
          });
        },
        dialogBox: false,
        isExpanded: true,
        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
      );
  }*/

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
