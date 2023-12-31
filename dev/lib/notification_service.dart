import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
// Import this for Int64List
import 'package:flutter/foundation.dart';



class NotificationManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize time zones
    tzdata.initializeTimeZones();
    final location = tz.local;
    tz.setLocalLocation(location);

    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon'); // Replace with your app's icon name

    // Initialization settings (without iOS)
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null, // Remove iOS settings
    );

    // Initialize the notification plugin
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    // Create a notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id', // Replace with your Android channel ID
      'Your Channel Name',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // Android notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Replace with your Android channel ID
      'Your Channel Name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
   // Convert the list of int to Int64List
    );

    // Notification details
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Convert scheduledTime to a TZDateTime
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      scheduledTime,
      tz.local,
    );

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      title, // Title
      body, // Body
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'item x',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
