import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  final androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  final settings = InitializationSettings(android: androidSettings);
  await flutterLocalNotificationsPlugin.initialize(settings);

  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

Future<void> showNotification(String title, String body) async {
  const androidDetails = AndroidNotificationDetails(
    'channel_id',
    'Pemberitahuan',
    importance: Importance.max,
    priority: Priority.high,
  );

  const platformDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(0, title, body, platformDetails);
}
