import 'dart:io';

import 'package:flutter/material.dart';

import '../../Control/UsuarioDB.dart';
import '../../Modelo/Usuario.dart';
import '../PopMenu/Perfil.dart';

class PopMenu {
  menu(context) {
    return PopupMenuButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        )),
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
        itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: const [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  Text("Mi cuenta")
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: const [
                  Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  Text("Configuracion")
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: const [
                  Icon(
                    Icons.logout_rounded,
                    color: Colors.black,
                  ),
                  Text("Salir")
                ],
              ),
            ),
          ];
        },
        onSelected: (value) async {
          if (value == 0) {
            Usuario i = await UsuarioDB().find2();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Perfil(i)),
            );
          } else if (value == 1) {
            Navigator.pushNamed(context, '/setting');
          } else if (value == 2) {
            exit(0);
          }
        });
  }
}
