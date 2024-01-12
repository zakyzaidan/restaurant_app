import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/ui/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      home: HomePage(),
      getPages: [
        GetPage(name: "/", page: () => HomePage()),
        GetPage(name: "/detail", page: () => DetailPage()),
        GetPage(name: "/search", page: () => SearchPage()),
      ],
      // routes: {
      //   HomePage.routeName: (context) => HomePage(),
      //   DetailPage.routeName:(context) => DetailPage()
      // },
    );
  }
}
