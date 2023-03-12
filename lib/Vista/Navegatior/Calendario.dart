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
        body: panel());
  }

  Widget panel() {
    return Container(
        height: 200,
        width: 200,
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    band = false;
                  });
                },
                child: Text("Parar"))
          ],
        ));
  }
}