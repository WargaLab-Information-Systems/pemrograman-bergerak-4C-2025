import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notif = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: ios);
    await _notif.initialize(initSettings);
  }

  Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
        'channel_id', 'Foto Notification',
        importance: Importance.max);
    const notifDetails = NotificationDetails(android: androidDetails);
    await _notif.show(0, title, body, notifDetails);
  }
}
