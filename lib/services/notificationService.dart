import 'package:benecol_flutter/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

//Reference: https://www.youtube.com/watch?v=bRy5dmts3X8
class NotificationService{
  static final _notifications = FlutterLocalNotificationsPlugin();

  static init(BuildContext context) async{
    

    Future selectNotification(String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
        await Navigator.pushNamed(context, payload);
      }
    }

    Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
      // _notifications.schedule(id, title, body, scheduledDate, notificationDetails)
      // _notifications.zonedSchedule(id, title, body, scheduledDate, notificationDetails, uiLocalNotificationDateInterpretation: uiLocalNotificationDateInterpretation, androidAllowWhileIdle: androidAllowWhileIdle)
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title!),
          content: Text(body!),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, HomeScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
    // final MacOSInitializationSettings initializationSettingsMacOS =MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS
    );

    _notifications.initialize(
      initializationSettings,
      // onSelectNotification: selectNotification
    );
  }


  static Future _notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload
  }) async => 
    _notifications.show(
      id, 
      title, 
      body, 
      await _notificationDetails(),
      payload: payload
  );

  static Future<void> scheduleNotification(
      int id, 
      String title, 
      String body, 
      Duration duration,
    ) async {
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));

    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(duration),
      const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id', 
            'your channel name', 
            'your channel description'
          )
        ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime
    );
  }

  static Future<void> clearAllSchedule() async{
    await _notifications.cancelAll();
  }

  static Future<PermissionStatus> getNotificationStatus() async {
    // final serviceStatus = await Permission.notification;
    // print(serviceStatus);
    // print(Permission.values);
    // print(Permission.notification.status);
    final status = await Permission.notification.status;
    // print(status);
    // PermissionWidget(Permission.notification);
    return status;
  }

}