import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  final _notificationId = 1;

  NotificationService() { _initialise(); }

  void _initialise() async{
    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(initializationSettings);
    // requestNotificationPermission();
  }

  void showNotification(String message) {
    _plugin.show(
      _notificationId,
      "Subscription Update",
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
            'sub_tracker_channel', 'Subscription Tracker'
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  void cancelWorkoutNotification() {
    _plugin.cancel(_notificationId);
  }

  Future<void> requestNotificationPermission() async{
    if (Platform.isAndroid) {
      await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }
}
