import 'package:flutter/material.dart';

class PopMenu{
  menu(context){
    return PopupMenuButton(
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
               Radius.circular(20.0),
          )),
          // add icon, by default "3 dot" icon
          // icon: Icon(Icons.book)
          itemBuilder: (context){
            return [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Row(children: [Icon(Icons.person, color: Colors.black,),Text("Mi cuenta")],),
                      
                  ),

                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(children: [Icon(Icons.settings, color: Colors.black,),Text("Configuracion")],),
                  ),

                  PopupMenuItem<int>(
                      value: 2,
                      child:  Row(children: [Icon(Icons.logout_rounded, color: Colors.black,),Text("Salir")],),
                  ),
              ];
          },
          onSelected:(value){
            if(value == 0){
                print("My account menu is selected.");
            }else if(value == 1){
              Navigator.pushNamed(context, '/config');
              
            }else if(value == 2){
                Navigator.pushNamed(context, '/login');
            }
          }
        );
  }
}