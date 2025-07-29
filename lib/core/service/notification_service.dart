import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;
  final _notificationId = 1;

  NotificationService(this._plugin) { _initialise(); }

  void _initialise() async{
    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(initializationSettings);
    requestNotificationPermission();
  }

  void showWorkoutNotification(String message) {
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

  void requestNotificationPermission() {
    if (Platform.isAndroid) {
      _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }
}
