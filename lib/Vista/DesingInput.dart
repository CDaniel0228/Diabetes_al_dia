import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DesingInput {
  
  // ignore: non_constant_identifier_names
  CustomInput(control, icono, hint) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: control,
        //initialValue: 'Input text',
        maxLength: 20,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 224, 224, 224),
          icon: Icon(icono),
          labelText: hint,
          labelStyle: const TextStyle(
            color: Color(0xFF6200EE),
          ),
          helperText: 'Helper text',
          suffixIcon: const Icon(
            Icons.check_circle,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6200EE)),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  CustomInputDate(control,context,setState){
     return Container(
      margin: const EdgeInsets.only(bottom: 10),
    child: TextField(
      controller: control, 
      decoration: const InputDecoration(
          filled: true,
          fillColor:  Color.fromARGB(255, 224, 224, 224),
          icon: Icon(Icons.calendar_today),
          labelText: "Fecha nacimiento",
          labelStyle:  TextStyle(
            color: Color(0xFF6200EE),
          ),
          suffixIcon: Icon(
            Icons.check_circle,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6200EE)),
          ),
        ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        String year;
        DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
      String aux="";
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      DateTime date3 = DateTime.parse(formattedDate);
      final date2 = DateTime.now().difference(date3).inDays;
      aux=formattedDate;
      int A = date2 ~/ 365;
      int M = date2 ~/ 30;
      if (A >= 2) {
        year = "$A Años";
      } else {
        year = "$M Meses";
      }
    } else {
      year = "Fecha no seleccionada";
    }
          setState(()  {
            control.text = aux;
            print(aux);
          });
        
      },
    ));
  }

  
}
