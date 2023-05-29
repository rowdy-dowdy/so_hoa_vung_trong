import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/controllers/auth_controller.dart';
import 'package:so_hoa_vung_trong/services/local_notifications.dart';

class FirebaseCloudMessagingService {
  final Ref ref;
  final FirebaseMessaging fcm;
  NotificationSettings? settings;

  FirebaseCloudMessagingService({
    required this.ref,
    required this.fcm,
  }) {
    init();
    ref.listen(authControllerProvider, 
    (oldValue, newValue) {
      if (oldValue?.user == null && newValue.user != null) {
        subscribeToTopic(newValue.user);
      }
      else if (oldValue?.user != null && newValue.user == null) {
        unsubscribeFromTopic(oldValue?.user);
      }
    });
  }

  Future init() async {
    settings = await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOpenedAppHandler);

    // print(await fcm.getToken());
  }
  

  Future _firebaseMessagingForegroundHandler(RemoteMessage event) async {
    print(event);
    if (event.notification != null) {
      var id = DateTime.now().microsecond;
      ref.read(localNotificationServiceProvider).showNotification(id, event.notification!.title, event.notification!.body); 
    }
  }

  Future _firebaseMessagingOpenedAppHandler(RemoteMessage message) async {
    print("Handling a opened app message: ${message .messageId}");
    ref.read(localNotificationServiceProvider).openedNotification(null);
  }

  Future subscribeToTopic(dynamic user) async {
    // final user = ref.watch(authControllerProvider).user;
    print("${user.runtimeType} subscribe");
    await fcm.subscribeToTopic("user-${user.id}");
  }

  Future unsubscribeFromTopic(dynamic user) async {
    // final user = ref.watch(authControllerProvider).user;
    print("${user.runtimeType} unsubscribe");

    await fcm.unsubscribeFromTopic("user-${user.id}");
  }
}

final firebaseCloudMessagingServiceProvider = Provider((ref) {
  return FirebaseCloudMessagingService(fcm: FirebaseMessaging.instance, ref: ref);
});