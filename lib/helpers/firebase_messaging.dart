import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHelper {
  Future<void> setUpPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
  }
}
