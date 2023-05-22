// ignore: file_names
import 'package:diabetes_al_dia/Control/AlarmasDB.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../Control/CalendarioDB.dart';
import 'PopMenu.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> calendario = [];
  bool band = true;
  String pathImage = "asset/Farmaco/";
  String? weekday;

  @override
  void initState() {
    super.initState();
    _fetchListItems().then((datos) {
      // Aquí puedes realizar operaciones con los datos cargados
      print(datos);
    });
  }

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

  _fetchListItems() async {
    await initializeDateFormatting('es');
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE', 'es').format(now).substring(0, 3);
    List<Map<String, dynamic>> lista = await CalendarioDB().find(dayName);
    setState(() {
      calendario = lista;
    });
  }

  Widget panel() {
    return Container(
        child: Column(
      children: [
        Text("Mis medicamentos"),
        WeekdaysGrid(),
        Text("Hoy"),
        listaProducto(context),
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

  Widget articulos(context, imagen, nombre, cantidad, dosis, hora) {
    return Container(
        width: 350,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          Image.asset(imagen),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(nombre,
                  style: TextStyle(
                    fontSize: 15,
                  )),
              Text("$cantidad pildora [$dosis mg]"),
              Text(hora)
            ],
          )
        ]));
  }

  Widget listaProducto(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Container(
          height: 535,
          child: ListView(
            children: generateItem(context),
            addAutomaticKeepAlives: false,
            scrollDirection: Axis.vertical,
          )),
    );
  }

  List<Widget> generateItem(context) {
    final list = <Widget>[];
    for (int i = 0; i < calendario.length; i++) {
      print(calendario[i]['dias']);
      list.add(articulos(
          context,
          calendario[i]['tipo'],
          calendario[i]['nombre'],
          calendario[i]['cantidad'],
          calendario[i]['dosis'],
          calendario[i]['hora']));
      //Separa las Columnas
      // list.add(Divider());
    }
    return list;
  }

  Widget WeekdaysGrid() {
    List<String> weekdays = ["Lun", "Mar", "Mie", "Jue", "Vie", "Sab", "Dom"];
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: weekdays.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemBuilder: (BuildContext context, int index) {
        weekday = weekdays[index];

        bool isToday =
            DateTime.now().weekday == index + 1; // Check if it's today
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isToday
                  ? Colors.blue
                  : Colors.transparent, // Highlight today's date
              width: 2.0,
            ),
          ),
          child: Center(
            child: Text(
              weekday!,
              style: TextStyle(
                fontSize: 18.0,
                color: isToday ? Colors.blue : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
