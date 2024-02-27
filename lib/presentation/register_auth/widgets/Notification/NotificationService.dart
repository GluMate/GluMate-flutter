import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final List<String> _tips = [];

  Future<void> init() async {
    await _readTipsFromFile();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('FCM Message Received: ${message.notification?.body}');
      String tip = _getRandomTip();
      _showNotification(tip);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Opened App from Notification: ${message.notification?.body}');
    });

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _readTipsFromFile() async {
    try {
      final String tips = await rootBundle.loadString('assets/tips.txt');
      _tips.addAll(tips.split('\n\n'));
    } catch (e) {
      print('Error reading tips file: $e');
    }
  }

  String _getRandomTip() {
    final int index = DateTime.now().microsecondsSinceEpoch % _tips.length;
    return _tips[index];
  }

  Future<void> _showNotification(String tip) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '2923942808585773315',
      'tip of the day',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'New Tip!',
      tip,
      platformChannelSpecifics,
      payload: 'item x',
    );

    const tenMinutes = Duration(minutes: 10);
    Timer.periodic(tenMinutes, (Timer timer) async {
      await _flutterLocalNotificationsPlugin.show(
        0,
        'New Tip!',
        tip,
        platformChannelSpecifics,
        payload: 'item x',
      );
    });
  }
}
