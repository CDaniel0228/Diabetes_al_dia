// ignore: file_names
import 'package:flutter/material.dart';

import 'PopMenu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool band = true;
  String pathImage="asset/Farmaco/";
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
        WeekdaysGrid(),
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
          Image.asset("${pathImage}jeringa.png"),
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


class WeekdaysGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<String> weekdays = ["Lun", "Mar", "Mie", "Jue", "Vie", "Sab", "Dom"];
    return 
       GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      itemCount: weekdays.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemBuilder: (BuildContext context, int index) {
        String weekday = weekdays[index];
        
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
              weekday,
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