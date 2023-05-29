import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final Ref ref;
  final FlutterLocalNotificationsPlugin localNotification;

  LocalNotificationService({
    required this.ref,
    required this.localNotification,
  }) {
    init();
  }

  Future init() async {
    const androidSettings = AndroidInitializationSettings("drawable/icon_notification");
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true
    );

    var initializationSettings = const InitializationSettings(
      android: androidSettings,
      iOS: iosSettings
    );

    localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: openedNotification
    );
  }

  Future showNotification(int id, String? title, String? body) async {
    var androidDetails = const AndroidNotificationDetails(
      "1",
      "local",
      priority: Priority.max,
      importance: Importance.max,
      icon: "drawable/icon_notification",
      playSound: true,
      color: Color(0xFF22c55e),
      enableVibration: true,
    );

    var iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails
    );

    localNotification.show(id, title, body, notificationDetails);
  }

  void openedNotification(NotificationResponse? details) async {
  }
}

final localNotificationServiceProvider = Provider((ref) {
  return LocalNotificationService(ref: ref, localNotification: FlutterLocalNotificationsPlugin());
});