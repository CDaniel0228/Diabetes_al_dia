import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _isEnabled = false;
  TimeOfDay _time = TimeOfDay.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  List _selectedDays=["Lunes", "Martes","Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"];
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Nueva alarma'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Días de la semana:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildDayButton('Lunes'),
                          _buildDayButton('Martes'),
                          _buildDayButton('Miércoles'),
                          _buildDayButton('Jueves'),
                          _buildDayButton('Viernes'),
                          _buildDayButton('Sábado'),
                          _buildDayButton('Domingo'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Hora:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          Switch(
                            value: _isEnabled,
                            onChanged: (value) {
                              setState(() {
                                _isEnabled = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Fecha de finalización:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                          ])
                    ]))));
  }
  Widget _buildDayButton(String day) {
  final isSelected = _selectedDays.contains(day);

  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: isSelected
          ? MaterialStateProperty.all<Color>(Colors.blue)
          : null,
    ),
    onPressed: () {
      setState(() {
        if (isSelected) {
          _selectedDays.remove(day);
        } else {
          _selectedDays.add(day);
        }
      });
    },
    child: Text(
      day,
      style: TextStyle(
        color: isSelected ? Colors.white : null,
      ),
    ),
  );
}

}
