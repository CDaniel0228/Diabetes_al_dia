import 'dart:math';

import 'package:diabetes_al_dia/Control/UsuarioDB.dart';
import 'package:diabetes_al_dia/Modelo/Usuario.dart';
import 'package:diabetes_al_dia/Vista/DesingInput.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController boxNombres = TextEditingController();
  final boxApellidos = TextEditingController();
  final boxEstatura = TextEditingController();
  final boxPeso = TextEditingController();
  final boxCalorias = TextEditingController();
  TextEditingController fechaNacimiento = TextEditingController();
  String boxGenero = "female";
  String pathImage = "asset/Avatar/";
  String imgAvatar = "him1.jpg";
  int currentStep = 0;

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('wizart', isViewed);
    print(prefs.getInt('wizart'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cuestionario",
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF11253c),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Theme(
              data: ThemeData(
                //canvasColor: Colors.yellow,
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: Color(0xFF11253c),
                      // background: Colors.red,
                      //secondary: Colors.green,
                    ),
              ),
              child: Stepper(
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  final isLastStep = (currentStep == getSteps().length - 1);
                  return Row(children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(60)),
                          onPressed: controls.onStepContinue,
                          child: (isLastStep)
                              ? Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        Random random = Random();
                                        int aleatorio = random.nextInt(4);
                                        if (boxGenero == "female") {
                                          List<String> imagen = [
                                            "mim1.jpg",
                                            "mim2.jpg",
                                            "mim3.jpg",
                                            "mim4.jpg"
                                          ];
                                          imgAvatar = pathImage +
                                              imagen.elementAt(aleatorio);
                                        } else {
                                          List<String> imagen = [
                                            "him1.jpg",
                                            "him2.jpg",
                                            "him3.jpg",
                                            "him4.jpg"
                                          ];
                                          imgAvatar = pathImage +
                                              imagen.elementAt(aleatorio);
                                        }
                                        print("Aletorio $aleatorio");
                                        if (camposBacios()) {
                                          UsuarioDB().crateItem(Usuario(
                                              nombres: boxNombres.text,
                                              apellidos: boxApellidos.text,
                                              fecha_nacimiento:
                                                  fechaNacimiento.text,
                                              genero: boxGenero,
                                              peso: double.parse(boxPeso.text),
                                              estatura: double.parse(
                                                  boxEstatura.text),
                                              imagen: imgAvatar));
                                          await _storeOnboardInfo();
                                          Navigator.pushNamed(context, '/navs');
                                        } else {
                                          print("object");
                                        }
                                      },
                                      child: Text("Terminar"),
                                      style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: Color(0xFF11253c)),
                                    ),
                                    TextButton(
                                        onPressed: controls.onStepCancel,
                                        child: const Text(
                                          "Cancel",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ))
                                  ],
                                )
                              : Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: controls.onStepContinue,
                                      child: Text("Siguiente"),
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: controls.onStepCancel,
                                        child: const Text(
                                          "Cancel",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ))
                                  ],
                                )),
                    )
                  ]);
                },
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepCancel: () => currentStep == 0
                    ? null
                    : setState(() {
                        currentStep -= 1;
                      }),
                onStepContinue: () {
                  bool isLastStep = (currentStep == getSteps().length - 1);
                  if (isLastStep) {
                    print("object");
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepTapped: (step) => setState(() {
                  currentStep = step;
                }),
                steps: getSteps(),
              ))),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Mis datos"),
        content: Column(
          children: [
            DesingInput().CustomInput(boxNombres, Icons.person, "Nombres"),
            DesingInput().CustomInput(boxApellidos, Icons.person, "Apellidos"),
            DesingInput().CustomInputDate(fechaNacimiento, context, setState),
            Row(
              children: [
                Text("Genero:"),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 1,
                    child: RadioListTile(
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      title:
                          const Text("Mujer", style: TextStyle(fontSize: 14)),
                      value: "female",
                      groupValue: boxGenero,
                      onChanged: (value) {
                        setState(() {
                          boxGenero = value!;
                        });
                      },
                    )),
                Expanded(
                    flex: 1,
                    child: RadioListTile(
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      title:
                          const Text("Hombre", style: TextStyle(fontSize: 14)),
                      value: "male",
                      groupValue: boxGenero,
                      onChanged: (value) {
                        setState(() {
                          boxGenero = value!;
                        });
                      },
                    )),
              ],
            ),
            DesingInput().CustomInput(boxPeso, Icons.person, "Peso"),
            DesingInput().CustomInput(boxEstatura, Icons.person, "Estatura"),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Estado actual"),
        content: Column(
          children: [
            const Text("¿Esta siguiendo una dieta especial?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            preguntas(),
            const Text("¿Esta tomando insulina u otro medicamento?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            preguntas(),
            const Text("¿Ha sufrido alguna vez un coma diabetico?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            preguntas(),
            const Text(
                "¿Tiene dificultad en la vision o trastorno de la vista?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            preguntas(),
            const Text("¿Sufre o a sufrido de la presion alta?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            preguntas(),
            const Text("¿Se hace analisis regulares de azucar en la orina?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            preguntas()
            //Precion alta
            //sufre de Problemas caridacos
            //problemas de riñones
            //se le verifico presencia anormal de azucar en la sangre
            //Esta tomando insulina u otros medicamentos
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Dieta"),
        content: Column(
          children: [
            DesingInput()
                .CustomInput(boxCalorias, Icons.person, "Consumo de Calorias"),
            const Text("¿Sigue una dieta especial?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            preguntas(),
            DesingInput().CustomInput(
                boxCalorias, Icons.person, "Que alimentos suele consumir"),
            //Ejercicio
            //
          ],
        ),
      ),
    ];
  }

  camposBacios() {
    return boxNombres.text.isNotEmpty &
        boxApellidos.text.isNotEmpty &
        boxGenero.isNotEmpty &
        boxPeso.text.isNotEmpty &
        boxEstatura.text.isNotEmpty &
        fechaNacimiento.text.isNotEmpty;
  }

  preguntas() {
    return Row(children: [
      Expanded(
          flex: 1,
          child: RadioListTile(
            title: Text("Si",
                style: TextStyle(
                  fontSize: 14,
                )),
            value: "Si",
            groupValue: boxGenero,
            onChanged: (value) {
              boxGenero = value!;
            },
          )),
      Expanded(
          flex: 1,
          child: RadioListTile(
            title: Text("No", style: TextStyle(fontSize: 14)),
            value: "male",
            groupValue: boxGenero,
            onChanged: (value) {
              boxGenero = value!;
            },
          )),
    ]);
  }
}
