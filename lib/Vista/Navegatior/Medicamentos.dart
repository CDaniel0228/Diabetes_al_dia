// ignore: file_names
import 'package:flutter/material.dart';

import 'PopMenu.dart';

class Camaras extends StatelessWidget{
  const Camaras({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Medicamentos"),
        backgroundColor: Color(0xFF11253c),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [PopMenu().menu(context)],
      ),
      body:Container(
         alignment: Alignment.topCenter, //inner widget alignment to center
         padding: EdgeInsets.all(20),
        
      ),
    );
  }
}
