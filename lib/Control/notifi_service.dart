import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
      
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, sound: RawResourceAndroidNotificationSound('asset/tono.mp3')),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
  Future<void> scheduleNotification2({
  int id = 0,
  String? title,
  String? body,
  String? payLoad,
  required DateTime scheduledNotificationDateTime,
  List<int>? daysOfWeek, // Lista de días de la semana en los que se programará la notificación
}) async {
  
  if (daysOfWeek != null && daysOfWeek.isNotEmpty) {
    // Filtrar los días de la semana seleccionados
    final filteredDays = daysOfWeek.where((day) => day >= 1 && day <= 7).toSet();
    
    if (filteredDays.isNotEmpty) {
      final now = DateTime.now();
      final currentDay = now.weekday;
      final scheduledDay = scheduledNotificationDateTime.weekday;
      final scheduledTime = scheduledNotificationDateTime;

      // Calcular el próximo día de la semana seleccionado
      int nextDay = filteredDays.firstWhere((day) => day >= currentDay, orElse: () => filteredDays.first);

      if (currentDay == scheduledDay && now.isBefore(scheduledTime)) {
        // Si el día actual es igual al día programado y la hora aún no ha pasado,
        // se programará la notificación para hoy a la hora elegida
        final notificationDateTime = DateTime(now.year, now.month, now.day, scheduledTime.hour, scheduledTime.minute);
        await notificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(notificationDateTime, tz.local),
          await notificationDetails(),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );
      } else {
        // Calcular el siguiente día de la semana seleccionado
        if (nextDay == currentDay) {
          nextDay = filteredDays.firstWhere((day) => day >= 1, orElse: () => filteredDays.first);
        }

        // Calcular la diferencia de días hasta el siguiente día seleccionado
        final dayDifference = nextDay - currentDay;
        final nextNotificationDate = now.add(Duration(days: dayDifference));

        // Programar la notificación para el siguiente día seleccionado a la hora elegida
        final notificationDateTime = DateTime(nextNotificationDate.year, nextNotificationDate.month, nextNotificationDate.day, scheduledTime.hour, scheduledTime.minute);
        await notificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(notificationDateTime, tz.local),
          await notificationDetails(),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  } else {
    // Si no se especifican días de la semana, programar la notificación para la fecha y hora especificadas
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
      await notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
}
