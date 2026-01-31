import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/main.dart';
import 'package:my_app/routes_names.dart';
import 'package:my_app/core/services/shared_preferences_service.dart';

class PushMessagingService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> toggleNotifications(bool isEnabled) async {
    await _firebaseMessaging.setAutoInitEnabled(isEnabled);

    if (isEnabled) {
      await _firebaseMessaging.subscribeToTopic('breaking_news');
    } else {
      await _firebaseMessaging.unsubscribeFromTopic('breaking_news');
    }
  }

  Future<void> initNotifications() async {
    final bool isEnabled =
        SharedPreferencesService.getNotifications(kNotifications);

    if (isEnabled) {
      await _firebaseMessaging.requestPermission();
      await _firebaseMessaging.subscribeToTopic('breaking_news');
    }

    await _firebaseMessaging.setAutoInitEnabled(isEnabled);

    final fcmToken = await _firebaseMessaging.getToken();
    log("Token: ${fcmToken.toString()}");
    pushInitNotifications();
  }

  void handleMessages(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(bottomNavigationBar);
  }

  Future pushInitNotifications() async {
    _firebaseMessaging.getInitialMessage().then(handleMessages);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }
}
