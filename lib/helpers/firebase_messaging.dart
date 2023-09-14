import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHelper {
  final fcm = FirebaseMessaging.instance;

  Future<void> setUpPushNotification() async {
    await fcm.requestPermission();
    await fcm.subscribeToTopic("Features");
  }

  Future<String?> getFcmToken() async {
    final token = await fcm.getToken();
    return token;
  }

  Future<void> subscribeToGCTopic(String topicName) async {
    await fcm.subscribeToTopic(topicName);
  }

  Future<void> unsubscribeFromTopic(String topicName) async {
    try {
      await fcm.unsubscribeFromTopic(topicName);
      print('Unsubscribed from topic: $topicName');
    } catch (e) {
      print('Error unsubscribing from topic: $e');
    }
  }
}
