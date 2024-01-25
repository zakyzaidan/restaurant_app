

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/controllers/navigationbar_controller.dart';
import 'package:restaurant_app/helper/notification_helper.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/profile_page.dart';

class LandingPage extends StatefulWidget {

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final NavigationBarController navbarController = Get.put(NavigationBarController());
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: navbarController.tabIndex.value,
            backgroundColor: secondaryColor,
            onTap: (index) => navbarController.changeTabIndex(index),
            iconSize: 30,
            selectedLabelStyle: const TextStyle(color: tertiaryColor, fontSize: 20),
            unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 17),
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home, color: primaryColor),
                icon: Icon(Icons.home_outlined,color: tertiaryColor,),
                label: "home",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite_rounded, color: primaryColor),
                icon: Icon(Icons.favorite_outline_sharp,color: tertiaryColor),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.people, color: primaryColor),
                icon: Icon(Icons.people_outline,color: tertiaryColor),
                label: "Profile",
              ),
            ],
          );
        }
      ),
      body: Obx(() => IndexedStack(
        index: navbarController.tabIndex.value,
        children: [
          HomePage(),
          FavoritePage(),
          const ProfilePage()
        ],
      )),
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}