import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHelper {
  Future<void> setUpPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();
    await fcm.subscribeToTopic("Features");

    final token = await fcm.getToken();
    print(token);
  }
}
