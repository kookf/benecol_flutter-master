import 'package:benecol_flutter/services/notificationService.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;

class MyFirebaseSingleton{
  static final MyFirebaseSingleton _instance = MyFirebaseSingleton._private();

  factory MyFirebaseSingleton(){
    return _instance;
  }

  MyFirebaseSingleton._private();

  late final FirebaseMessaging _messaging;

  init() async {
    print('[Firebase] init');
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();
    await getToken();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: false,
      provisional: false,
      sound: true,
    );

    if (Platform.isIOS) {
      // Required to display a heads up notification
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: false,
        sound: true,
      );
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('[Firebase] User granted permission');
      // handle the received notifications
      // For handling the received notifications

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        // PushNotification notification = PushNotification(
        //   title: message.notification?.title,
        //   body: message.notification?.body,
        // );
        print('[Firebase] onMessage triggered');
        if (Platform.isAndroid) {
          NotificationService.scheduleNotification(10, message.notification?.title ?? '', message.notification?.body ?? '', Duration(seconds: 1));
        }
      });

    } else {
      print('[Firebase] User declined or has not accepted permission');
    }
  }

  getToken() async {
    if (Platform.isIOS) {
      String apnstoken = await FirebaseMessaging.instance.getAPNSToken() ?? "";
      print("APNSToken: $apnstoken");
    }
    String fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    print("FCMToken: $fcmToken");
  }

  void registerBackgroundHandle(Future<void> Function(RemoteMessage) $handler){
    FirebaseMessaging.onBackgroundMessage($handler);
  }

  void subscribeTestingTopic() {
    print('[FireBase] subscribed to testingTopic');
    _messaging.subscribeToTopic('testingTopic');
  }

  void unSubscribeTestingTopic() {
    print('[FireBase] unSubscribed to testingTopic');
    _messaging.unsubscribeFromTopic('testingTopic');
  }

  void subscribeTopic($name) {
    String _topicName = $name;
    if($name == 'PROD'){
      _topicName = $name+'_yU6zZ0YygD';
    }
    print('[FireBase] subscribed to ${_topicName}');
    _messaging.subscribeToTopic(_topicName);
  }
}