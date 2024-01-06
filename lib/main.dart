import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName:(context) => DetailPage(
          data: ModalRoute.of(context)?.settings.arguments as Restaurant,
        )
      },
    );
  }
}
