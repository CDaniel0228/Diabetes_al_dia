import 'package:diabetes_al_dia/Vista/DesingInput.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController? nombre, apellido, estatura;
  TextEditingController fechaNacimiento=TextEditingController();
  String? genero;
  int currentStep = 0;
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
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
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
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/navs');
                                  },
                                  child: const Text("Terminar"),
                                  style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      backgroundColor: Color(0xFF11253c)),
                                ),
                                TextButton(
                                    onPressed: controls.onStepCancel,
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white70),
                                    ))
                              ],
                            )
                          : Row(
                              children: [
                                ElevatedButton(
                                  onPressed: controls.onStepContinue,
                                  child: const Text("Siguiente"),
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                  ),
                                ),
                                TextButton(
                                    onPressed: controls.onStepCancel,
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white70),
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
          )))  ,
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
            DesingInput().CustomInput(nombre, Icons.person, "Nombres"),
            DesingInput().CustomInput(apellido, Icons.person, "Apellidos"),
            
            DesingInput().CustomInputDate(fechaNacimiento, context, setState),
            
            Row(
              children: [
                Text("Genero:"),
                SizedBox(width: 20,),
                Expanded(
                    flex: 1,
                    child: RadioListTile(
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      
                      title: Text("Mujer", style: TextStyle(fontSize: 14)),
                      
                      value: "female",
                      groupValue: genero,
                      onChanged: (value) {
                        genero = value;
                      },
                    )),
                Expanded(
                    flex: 1,
                    child: RadioListTile(
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      title: Text("Hombre", style: TextStyle(fontSize: 14)),
                     value: "male",
                      groupValue: genero,
                      onChanged: (value) {
                        genero = value;
                      },
                    )),
              ],
            ),
            DesingInput().CustomInput(estatura, Icons.person, "Peso"),
            DesingInput().CustomInput(estatura, Icons.person, "Estatura"),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Estado actual"),
        content: Column(
          children: [
            Text("¿Esta siguiendo una dieta especial?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
            preguntas(),
            Text("¿Esta tomando insulina u otro medicamento?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
            preguntas(),
            Text("¿Ha sufrido alguna vez un coma diabetico?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
            preguntas(),
            Text("¿Tiene dificultad en la vision o trastorno de la vista?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
            preguntas(),
            Text("¿Sufre o a sufrido de la presion alta?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
            preguntas(),
            Text("¿Se hace analisis regulares de azucar en la orina?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
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
            DesingInput().CustomInput(nombre, Icons.person, "Consumo de Calorias"),
            Text("¿Sigue una dieta especial?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
            preguntas(),
            DesingInput().CustomInput(nombre, Icons.person, "Que alimentos suele consumir"),
            //Ejercicio
            //
          ],
        ),
      ),
    ];
  }

  preguntas(){
    return
           Row(
              children: [
                Expanded(
                    flex: 1,
                    child: RadioListTile(
                      title: Text("Si", style: TextStyle(fontSize: 14,)),
                      
                      value: "Si",
                      groupValue: genero,
                      onChanged: (value) {
                        genero = value;
                      },
                    )),
                Expanded(
                    flex: 1,
                    child: RadioListTile(
                      title: Text("No", style: TextStyle(fontSize: 14)),
                     value: "male",
                      groupValue: genero,
                      onChanged: (value) {
                        genero = value;
                      },
                    )),
              ]);
  }
}
