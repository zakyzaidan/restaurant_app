
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/helper/backgroud_service.dart';
import 'package:restaurant_app/helper/notification_helper.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/landing_page.dart';
import 'package:restaurant_app/ui/recomendation_page.dart';
import 'package:restaurant_app/ui/search_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
   FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: tertiaryColor,
          onPrimary: Colors.black
        ),
        scaffoldBackgroundColor: primaryColor,
        textTheme: myTextTheme,
        useMaterial3: true,
      ),
      home: LandingPage(),
      getPages: [
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/recomendation", page: () => RecomendationPage()),
        GetPage(name: "/detail", page: () => DetailPage()),
        GetPage(name: "/search", page: () => SearchPage()),
      ],
    );
  }
}
