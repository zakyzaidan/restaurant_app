

import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper{
    static NotificationHelper? _instance;
 
  NotificationHelper._internal() {
    _instance = this;
  }
 
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();
 
  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
 
    var initializationSettings = InitializationSettings(
       android: initializationSettingsAndroid,);
 
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');  
    });
  }
  
  Future<void> showNotification(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
     PurpleList restaurantList) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "Restaurant App"; 
    var random = Random();
 
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName, 
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));
 
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
 
    var titleNotification = "<b>Restaurant App</b>";
    var restaurant = restaurantList.restaurants;
    var randomNum = random.nextInt(restaurant.length);
    var titleResto = restaurant[randomNum].name;
 
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleResto, platformChannelSpecifics,
        payload: json.encode(restaurant[randomNum].toJson()));
  }
 
  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        Navigation.intentWithData(route, data.id);
      },
    );

  }

}