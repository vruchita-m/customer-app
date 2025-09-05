// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// class FirebaseUtils {
//
//   @pragma('vm:entry-point')
//   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     debugPrint("Notification Data : ${message.notification?.title}");
//     if (message.notification != null) {
//
//     }
//     return;
//   }
//
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   // Function to schedule a notification
// // Function to show notification immediately
//   void showNotificationImmediately() async {
//     // 1. Notification details waise hi rahenge
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'immediate_channel_id',
//       'Immediate Notifications',
//       channelDescription: 'Channel for immediate notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('sound1'),
//     );
//     const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
//
//     // 2. '.show()' method ka istemal karein
//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       'Immediate Notification', // Title
//       'Yeh notification turant dikha!', // Body
//       platformDetails,
//     );
//   }
//   late AndroidNotificationChannel channel;
//
//   void showFlutterNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     String? notificationTitle = notification?.title ?? message.data["title"];
//     String? notificationBody = notification?.body ?? message.data["body"];
//
//     if (notificationTitle != null || notificationBody != null) {
//       const String customSound = 'sound1';
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notificationTitle,
//         notificationBody,
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'high_importance_channel',
//             'High Importance Notifications',
//             channelDescription: 'This channel is used for important notifications.',
//             icon: 'ic_launcher',
//             importance: Importance.max,
//             priority: Priority.high,
//             playSound: true,
//             sound: RawResourceAndroidNotificationSound(customSound),
//           ),
//         ),
//       );
//     }
//   }
//
//   void firebaseInit(){
//     debugPrint("Notification Data : initialize");
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint("Notification Message : $message");
//       showFlutterNotification(message);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint("App opened via notification: $message");
//     });
//   }
//
// }




import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Background handler ab top-level function hai. Iska kaam ab notification dikhana nahi hai.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  debugPrint("Background message received: ${message.messageId}");
}

class FirebaseUtils {
  // Flutter local notifications ka instance
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // 1. Channel ki ek unique ID
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('sound1'),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'This channel is used for important notifications.',
            icon: 'ic_launcher',
            playSound: true,
            sound: RawResourceAndroidNotificationSound('sound1'),
          ),
        ),
      );
    }
  }

  void firebaseInit({VoidCallback? onNotificationReceived}) async {
    debugPrint("Firebase Notifications Initializing...");

    await _initializeLocalNotifications();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground message received: ${message.messageId}");

      showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("App opened via notification: ${message.messageId}");
    });
  }
}