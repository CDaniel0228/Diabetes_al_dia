import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Elementos extends StatefulWidget {
  const Elementos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ElementosState createState() => _ElementosState();
}

class _ElementosState extends State<Elementos> {
  TextEditingController? boxNombre, boxEstatura, boxPeso;
  TextEditingController boxEdad= TextEditingController();
  String gender = "No";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Cuestionario"),
        centerTitle: true,
        backgroundColor: Color(0xFF11253c),),
      body: SingleChildScrollView(child: Container(
      child: Column(
        children: [
          Text("Datos Personales", style: TextStyle(fontSize: 18),),
          Text("Porfavor digite su nombre completo"),
          campoNombre(boxNombre, true),
          Text("Porfavor digite su estatura cm"),
          campoEstatura(boxEstatura, true),
          Text("Porfavor digite su peso kg"),
          campoPeso(boxPeso, true),
          Text("Porfavor digite su fecha de nacimiento"),
          campoFechaNacimiento(context),
          
          //Tipo de diabetes diagnosticado
          //dieta(),
          //consumo de calorias
          //insulina u otro medicamento
          
          
          TextButton(onPressed: (){
            Navigator.pushNamed(context, '/navs');
          }, child: Text("Siguiente"))
        ],
      ),
    )));
  }

  Widget dieta(){
    return Row(children: [
      RadioListTile(
          title: Text("Si"),
          value: "Si", 
          groupValue: gender, 
          onChanged: (value){
            setState(() {
                gender = value.toString();
            });
          },
      ),

      RadioListTile(
          title: Text("No"),
          value: "No", 
          groupValue: gender, 
          onChanged: (value){
            setState(() {
                gender = value.toString();
            });
          },
      ),

    ],);
  }
  

  Widget campoNombre(boxNombre, band) {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxNombre,
            enabled: band,
            decoration: decoracionBox("Nombre")));
  }

  Widget campoNombreMedico(boxNombre, band) {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxNombre,
            enabled: band,
            decoration: decoracionBox("Nombre medico")));
  }

  Widget campoEstatura(boxEstatura, band) {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxEstatura,
            enabled: band,
            decoration: decoracionBox("Estatura")));
  }

  Widget campoPeso(boxPeso, band) {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: boxPeso,
            enabled: band,
            decoration: decoracionBox("Peso")));
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Genero", child: Text("Genero")),
      const DropdownMenuItem(value: "M", child: Text("M")),
      const DropdownMenuItem(value: "F", child: Text("F")),
    ];
    return menuItems;
  }

  Widget campoFechaNacimiento(BuildContext context) {
    String year;
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
    child: TextField(
      controller: boxEdad, //editing controller of this TextField
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(width: 3, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        prefixIcon: Icon(Icons.calendar_today),
          labelText: "Edad" //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        year=await funcionFecha(context);
          setState(()  {
            boxEdad.text = year;
          });
        
      },
    ));
  }

  Widget campoFechaPrimer(BuildContext context) {
    String year;
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
    child: TextField(
      controller: boxEdad, //editing controller of this TextField
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(width: 3, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        prefixIcon: Icon(Icons.calendar_today),
          labelText: "Edad" //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        year=await funcionFecha(context);
          setState(()  {
            boxEdad.text = year;
          });
        
      },
    ));
  }

  Widget campoFechaUltimo(BuildContext context) {
    String year;
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
    child: TextField(
      controller: boxEdad, //editing controller of this TextField
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(width: 3, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        prefixIcon: Icon(Icons.calendar_today),
          labelText: "Edad" //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        year=await funcionFecha(context);
          setState(()  {
            boxEdad.text = year;
          });
        
      },
    ));
  }
  

  funcionFecha(context) async {
    String year;
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      DateTime date3 = DateTime.parse(formattedDate);
      final date2 = DateTime.now().difference(date3).inDays;
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
    return year;
  }

  decoracionBuscar(nombre) {
    return InputDecoration(
        labelText: nombre,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
