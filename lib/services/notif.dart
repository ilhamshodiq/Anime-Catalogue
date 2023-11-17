import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('yep');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(0, title, body, notificationDetails,
        payload: payload);
  }

  // Future scheduleNotification(
  //     {int id = 0,
  //     String? title,
  //     String? body,
  //     String? payLoad,
  //     required DateTime scheduledNotificationDateTime}) async {
  //   return notificationsPlugin.zonedSchedule(
  //       id,
  //       title,
  //       body,
  //       tz.TZDateTime.from(
  //         scheduledNotificationDateTime,
  //         tz.local,
  //       ),
  //       await notificationDetails(),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }
  // Future showScheduleNotification({
  //   required int id,
  //   required String title,
  //   required String body,
  //   required DateTime time,
  //   required String payload,
  // }) async {
  //   tz.initializeTimeZones();
  //   final locationwib = tz.getLocation('Asia/Jakarta');
  //   final scheduledDate = tz.TZDateTime.from(time, locationwib);
  //
  //   print('Scheduled Notification: $id - $title');
  //   print('Scheduled Time: ${scheduledDate.toString()}');
  //
  //   await notificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     scheduledDate,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'channel 3',
  //         'your channel name',
  //         channelDescription: 'your channel description',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //         ticker: 'ticker',
  //       ),
  //     ),
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     payload: payload,
  //   );
  //
  //   print('Show schedule notification completed');
  // }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required String payload,
  }) async {
    // final details = await _notificationDetails();
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        date,
        tz.local,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel 3',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future cancel(int id) async {
    await notificationsPlugin.cancel(id);
  }
}
