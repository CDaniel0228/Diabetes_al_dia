import 'package:diabetes_al_dia/Control/AlarmasDB.dart';
import 'package:diabetes_al_dia/Modelo/alarmas_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Control/Mensajes.dart';

class AlarmScreen extends StatefulWidget {
  final List<Map<String, dynamic>> medicamentos;
  AlarmScreen(this.medicamentos);
  @override
  _AlarmScreenState createState() => _AlarmScreenState(medicamentos);
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<Map<String, dynamic>> medicamentos;
  _AlarmScreenState(this.medicamentos);
  bool _isEnabled = false;
  TimeOfDay _time = TimeOfDay.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  List _selectedDays = ["Lun", "Mar", "Mie", "Jue", "Vie", "Sab", "Dom"];
  List<String> dias = [];
  List nombres = [];
  int _selectedIndex = -1;
  String? selectedMedicamento;

  DateTime now = DateTime.now();

  void _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? newEndDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (newEndDate != null) {
      setState(() {
        _endDate = newEndDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    nombres = medicamentos.map((medicamento) => medicamento['nombre']).toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF11253c),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Nueva alarma'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              addMedicamentos(),
              SizedBox(height: 40.0),
              Text(
                'Días de la semana:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: -15.0,
                runSpacing: 0.0,
                children: [
                  _buildDayButton('Lun'),
                  _buildDayButton('Mar'),
                  _buildDayButton('Mie'),
                  _buildDayButton('Jue'),
                  _buildDayButton('Vie'),
                  _buildDayButton('Sab'),
                  _buildDayButton('Dom'),
                ],
              ),
              SizedBox(height: 8.0),
              Text("Dias Seleccionados",style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),),
              Text(dias.toString().substring(1, dias.toString().length - 1)),
              SizedBox(height: 16.0),
              const Text(
                'Hora:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  _time.format(context),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Duracion',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  _endDate.day.toString() +
                      '/' +
                      _endDate.month.toString() +
                      '/' +
                      _endDate.year.toString(),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                    onPressed: () => _selectEndDate(context),
                    child: Text('Seleccionar'))
              ]),
              SizedBox(height: 100,),
              Center(child: Container(
                width: 120,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Color(0xFF11253c)),
                  onPressed: () {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                    AlarmasDB().crateItem(AlarmasModel(
                        dias: dias
                            .toString()
                            .substring(1, dias.toString().length - 1),
                        fechaInicio: formattedDate,
                        hora: _time.format(context),
                        duracion: "1 mes",
                        medicamento: selectedMedicamento));
                    Mensajes().info("Se guardo con exito");
                  },
                  child: Text("Guardar",style: TextStyle(color: Colors.white),))))
              
            ])));
  }

  Widget _buildDayButton(String day) {
    final isSelected = _selectedDays.contains(day);

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? null : Colors.blue,
        shape: CircleBorder(),
      ),
      onPressed: () {
        setState(() {
          if (isSelected) {
            print(_selectedDays.indexOf(day));
            _selectedDays.remove(day);
            dias.add(day);
          } else {
            _selectedDays.add(day);
            dias.remove(day);
          }
        });
      },
      child: Text(
        day,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  Widget addMedicamentos() {
    return DropdownButtonFormField(
        value: selectedMedicamento,
        onChanged: (value) {
          setState(() {
            selectedMedicamento = value;
          });
        },
        items: nombres.map((medicamento) {
          return DropdownMenuItem<String>(
            value: medicamento,
            child: Text(medicamento),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Seleccione un medicamento',
          border: OutlineInputBorder(),
        ));
  }

  decoracionBox(nombre) {
    return InputDecoration(
        labelText: nombre,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
