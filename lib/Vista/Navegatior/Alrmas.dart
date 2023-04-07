import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../Control/notifi_service.dart';


DateTime scheduleTime = DateTime.now();

class Alarmas extends StatefulWidget {
  const Alarmas({super.key});

  @override
  State<Alarmas> createState() => _AlarmasState();
}

class _AlarmasState extends State<Alarmas> {
  TextEditingController? add;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alarmas"),
        backgroundColor: Color(0xFF11253c),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:   [
            Text("Duracion"),
            addMedicamentos(),
            Text("Horario"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text("8 horas"), Text("12 horas"), Text("24 horas")],),
            Text("Seleccionar fecha"),
            DatePickerTxt(),
            ScheduleBtn(),
          ],
        ),
    
    );
  }

   Widget addMedicamentos() {
    return Padding(
        //flatbutton
        padding: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: TextField(
            controller: add,
            enabled: true,
            decoration: decoracionBox("1 dia")));
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
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) => scheduleTime = date,
          onConfirm: (date) {},
        );
      },
      child: const Text(
        'Select Date Time',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Schedule notifications'),
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
            title: 'Scheduled Notification',
            body: '$scheduleTime',
            scheduledNotificationDateTime: scheduleTime);
      },
    );
  }
}
