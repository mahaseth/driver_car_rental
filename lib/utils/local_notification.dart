import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermissions() async {
    var status = await Permission.notification.status;

    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  Future<void> init() async {
    await requestNotificationPermissions();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }

  void showNotification(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('ride_notification', 'Rides Notification',
        channelDescription: 'Notification regarding new Rides',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, value, notificationDetails, payload: 'Not present');
  }
}
