import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../Modelo/Usuario.dart';

class Perfil extends StatefulWidget {
  Usuario lista;
  Perfil(this.lista, {super.key});
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _PerfilState createState() => _PerfilState(lista);
}

class _PerfilState extends State<Perfil> {
  Usuario lista;
  _PerfilState(this.lista);
  final boxNombres = TextEditingController();
  final boxApellidos = TextEditingController();
  final boxFechaNacimiento = TextEditingController();
  final boxPeso = TextEditingController();
  final boxEstatura = TextEditingController();
  bool bandN = false,
      bandA = false,
      bandF = false,
      bandP = false,
      bandE = false;
  var imageFile, nombrePath;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    boxNombres.text = lista.nombres.toString();
    boxApellidos.text = lista.apellidos.toString();
    boxFechaNacimiento.text = lista.fecha_nacimiento.toString();
    boxPeso.text = lista.peso.toString();
    boxEstatura.text = lista.estatura.toString();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          centerTitle: true,
          backgroundColor: Color(0xFF11253c),
        ),
        body: SingleChildScrollView(child: panel(context)));
  }

  Widget panel(BuildContext context) {
    return Container(
        child: Column(
      children: [
        imagenPerfil(context),
        campoTexto(bandN, boxNombres, "Nombres"),
        campoTexto(bandA, boxApellidos, "Apellidos"),
        campoTexto(bandF, boxFechaNacimiento, "Fecha de Nacimiento"),
        campoTexto(bandP, boxPeso, "Peso"),
        campoTexto(bandE, boxEstatura, "Estatura"),
        botonGuardar(context),
        
      ],
    ));
  }

  Widget imagenPerfil(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: 140,
          width: 160,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: imageFile != null
                      ? FileImage(File(imageFile))
                          as ImageProvider
                      : AssetImage(lista.imagen.toString()))),
          child: Stack(alignment: Alignment.center, children: [
            //Container
            Positioned(
                bottom: 1,
                right: 0,
                child: Container(
                  width: 50,
                  height: 50,
                  child: IconButton(
                      onPressed: () {
                        showSelectionDialog(context);
                      },
                      icon: Icon(Icons.camera_alt_outlined)),
                )),
          ]),
        ));
  }

  Widget campoTexto(band, control, hint) {
    return Row(children: [
      Container(
          width: 300,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: TextField(
              enabled: band,
              controller: control,
              decoration: decoracion(hint))),
      IconButton(
          onPressed: () {
            setState(() {
              switch (hint) {
                case "Nombres":
                  bandN = true;
                  break;
                case "Apellidos":
                  bandA = true;
                  break;
                case "Fecha de Nacimiento":
                  bandF = true;
                  break;
                case "Peso":
                  bandP = true;
                  break;
                case "Estatura":
                  bandE = true;
                  break;
                default:
              }
            });
          },
          icon: const Icon(Icons.edit_note_rounded))
    ]);
  }

  Widget botonGuardar(BuildContext context) {
    return Container(
        width: 300,
        padding: const EdgeInsets.only(top: 50, right: 50, left: 50),
        child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Color(0xFF11253c)),
          onPressed: () async {},
          child: const Text(
            "Guardar cambios",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ));
  }

  openCamera(BuildContext context) async {
    XFile? foto = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = foto?.path;
      nombrePath = foto?.name;
    });

    Navigator.of(context).pop();
  }

  openGallery(BuildContext context) async {
    XFile? foto = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = foto?.path;
      nombrePath = foto?.name;
    });
    Navigator.of(context).pop();
  }

  Widget setImageView() {
    if (imageFile != null) {
      return Image.file(
        File(imageFile),
        height: 300,
      );
    } else {
      return const Image(
        image: AssetImage('asset/Avatar/him1.jpg'),
        height: 300,
      );
    }
  }

  Future<void> showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Escoja una imagen para su perfil"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Galeria"),
                      onTap: () {
                        openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camara"),
                      onTap: () {
                        openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  decoracion(nombre) {
    return InputDecoration(
        labelText: nombre,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ));
  }
}
