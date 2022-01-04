import 'package:Kambusapp/DB/db.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/src/material/time.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification {
  static final Notification _notificationService = Notification._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int notificationId = 100;

  factory Notification() {
    return _notificationService;
  }

  Notification._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload == "homepage") productModel.setStackIndex(0);
    });
  }

  void scheduleNotification(TimeOfDay time) async {
    DateTime start = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, time.hour, time.minute);

    if (!DateTime.now().isBefore(start)) {
      start.add(Duration(days: 1));
    }

    print("$start");

    AndroidAlarmManager.periodic(
            Duration(hours: 24), notificationId, showNotification,
            exact: true,
            rescheduleOnReboot: true,
            allowWhileIdle: true,
            wakeup: true,
            startAt: start)
        .then((value) => print("scheduled: $value"));
    // _showNotification();
  }

  void deleteNotification() async {
    AndroidAlarmManager.cancel(notificationId)
        .then((value) => print("CANCEL: $value"));
  }

  static void showNotification() async {
    Notification notification = Notification();
    notification.init();

    int nearExpiration = await DBProdotti.dbProdotti.nearExpiration();
    int expired = await DBProdotti.dbProdotti.expired();

    String text = "Hai ${nearExpiration} " +
        (nearExpiration == 1 ? "prodotto " : "prodotti ") +
        "in scadenza";
    text += expired > 0
        ? " e ${expired} " +
            (nearExpiration == 1 ? "prodotto " : "prodotti ") +
            " scaduti! 😱"
        : "";

    if (nearExpiration + expired > 0) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.high,
              priority: Priority.high,
              fullScreenIntent: true,
              ticker: 'ticker');
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await notification.flutterLocalNotificationsPlugin.show(
          0, 'Kambusapp', text, platformChannelSpecifics,
          payload: 'homepage');
    }
  }
}

Notification notification = Notification();
