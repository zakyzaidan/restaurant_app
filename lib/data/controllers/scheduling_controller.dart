

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/helper/backgroud_service.dart';
import 'package:restaurant_app/helper/date_time_helper.dart';
import 'package:restaurant_app/helper/preference_helper.dart';

class SchedulingController extends GetxController{
  PreferenceHelper preferenceHelper;

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  RxString statusNotification = "Off".obs;

  SchedulingController({required this.preferenceHelper}){
    _getIsNotification();
    _getStatusNotification();
  }

  void _getIsNotification() async{
    _isScheduled = await preferenceHelper.isActiveNotification;
    update();
  }

  void enableNotification(bool value) async{
    preferenceHelper.setActiveNotification(value);
    _getIsNotification();
  } 

  void _getStatusNotification() async{
    statusNotification.value = (await preferenceHelper.getStatusNotification)!;
    update();
  }

  void changeStatusNotification(String value) async{
    preferenceHelper.setStatusNotification(value);
    _getStatusNotification();
  } 

  Future<bool> scheduledRestaurant(bool value) async {
    if (value) {
      // ignore: avoid_print
      print('Scheduling Restaurant Activated');
      changeStatusNotification("On");
      update();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      // ignore: avoid_print
      print('Scheduling Restaurant Canceled');
      changeStatusNotification("Off");
      update();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}