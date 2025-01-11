import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../screens/booking/view/booking_detail_screen.dart';
import '../screens/order/view/order_detail_screen.dart';
import 'app_common.dart';
import 'constants.dart';

class PushNotificationService {
  Future<void> setupFirebaseMessaging() async {
    await initFirebaseMessaging();

    await enableIOSNotifications();

    await registerFCMAndTopics();
  }

  Future<void> initFirebaseMessaging() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance.setAutoInitEnabled(true).then((value) {
      registerNotificationListeners();
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  }

  Future<void> registerFCMAndTopics() async {
    if (appStore.isLoggedIn) {
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          subScribeToTopic();
        } else {
          Future.delayed(const Duration(seconds: 3), () async {
            apnsToken = await FirebaseMessaging.instance.getAPNSToken();
            subScribeToTopic();
          });
        }
        log("===============${FirebaseMsgConst.apnsNotificationTokenKey}===============\n$apnsToken");
      } else {
        FirebaseMessaging.instance.getToken().then((token) {
          log("===============${FirebaseMsgConst.fcmNotificationTokenKey}===============\n$token");
        });
        subScribeToTopic();
      }
    }
  }

  Future<void> subScribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic(appNameTopic).whenComplete(() {
      log("${FirebaseMsgConst.topicSubscribed}$appNameTopic");
    });
    await FirebaseMessaging.instance.subscribeToTopic("${FirebaseMsgConst.userWithUnderscoreKey}${userStore.userId}").then((value) {
      log("${FirebaseMsgConst.topicSubscribed}${FirebaseMsgConst.userWithUnderscoreKey}${userStore.userId}");
    });
  }

  Future<void> unSubScribeToTopic() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(appNameTopic).whenComplete(() {
      log("${FirebaseMsgConst.topicUnSubscribed}$appNameTopic");
    });
    await FirebaseMessaging.instance.unsubscribeFromTopic("${FirebaseMsgConst.userWithUnderscoreKey}${userStore.userId}").then((value) {
      log("${FirebaseMsgConst.topicUnSubscribed}${FirebaseMsgConst.userWithUnderscoreKey}${userStore.userId}");
    });
  }

  Future<void> handleNotificationClick(RemoteMessage message, {bool isForeGround = false}) async {
    printLogsNotificationData(message);
    if (isForeGround) {
      showNotification(currentTimeStamp(), message.notification!.title.validate(), message.notification!.body.validate(), message);
    } else {
      try {
        if (message.data.containsKey(FirebaseMsgConst.additionalDataKey)) {
          final additionalData = json.decode(message.data[FirebaseMsgConst.additionalDataKey]);
          if (message.data.containsKey(FirebaseMsgConst.idKey)) {
            String? notId = message.data[FirebaseMsgConst.idKey];
            if (notId != null) {
              if (additionalData[FirebaseMsgConst.notificationGroupKey] == FirebaseMsgConst.shopKey) {
                navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => OrderDetailScreen(orderId: notId.toInt(), orderCode: additionalData[FirebaseMsgConst.orderCodeKey])));
              } else {
                navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => BookingDetailScreen(bookingId: notId.toInt())));
              }
            }
          } else {
            log("========= id Key is not available =======");
          }
        }
      } catch (e) {
        log("${FirebaseMsgConst.onClickListener} $e");
      }
    }
  }

  Future<void> registerNotificationListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleNotificationClick(message, isForeGround: true);
    }, onError: (e) {
      log("${FirebaseMsgConst.onMessageListen} $e");
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationClick(message);
    }, onError: (e) {
      log("${FirebaseMsgConst.onMessageOpened} $e");
    });

    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        Future.delayed(Duration(seconds: 4), () {
          handleNotificationClick(message);
        });
      }
    }, onError: (e) {
      log("${FirebaseMsgConst.onGetInitialMessage} $e");
    });
  }

  void showNotification(int id, String title, String message, RemoteMessage remoteMessage) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    //code for background notification channel
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'notification',
      'Notification',
      importance: Importance.high,
      enableLights: true,
      playSound: true,
      showBadge: true,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_stat_notification');

    var iOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        handleNotificationClick(remoteMessage);
      },
    );
    var macOS = iOS;
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: iOS, macOS: macOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        handleNotificationClick(remoteMessage);
      },
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      FirebaseMsgConst.notificationChannelIdKey,
      FirebaseMsgConst.notificationChannelNameKey,
      importance: Importance.high,
      visibility: NotificationVisibility.public,
      autoCancel: true,
      //color: primaryColor,
      playSound: true,
      priority: Priority.high,
      icon: '@drawable/ic_stat_notification',
    );

    var darwinPlatformChannelSpecifics = const DarwinNotificationDetails(
      sound: 'default',
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(id, title, message, platformChannelSpecifics);
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void printLogsNotificationData(RemoteMessage message) {
    log('${FirebaseMsgConst.notificationDataKey} : ${message.data}');
    log('${FirebaseMsgConst.notificationTitleKey} : ${message.notification?.title}');
    log('${FirebaseMsgConst.notificationBodyKey} : ${message.notification?.body}');
    log('${FirebaseMsgConst.messageDataCollapseKey} : ${message.collapseKey}');
    log('${FirebaseMsgConst.messageDataMessageIdKey} : ${message.messageId}');
    log('${FirebaseMsgConst.messageDataMessageTypeKey} : ${message.messageType}');
  }
}
