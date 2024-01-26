

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/helper/backgroud_service.dart';
import 'package:restaurant_app/helper/date_time_helper.dart';
import 'package:restaurant_app/helper/preference_helper.dart';

class SchedulingController extends GetxController{
  PreferenceHelper preferenceHelper;

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  SchedulingController({required this.preferenceHelper}){
    _getIsNotification();
  }

  void _getIsNotification() async{
    _isScheduled = await preferenceHelper.isActiveNotification;
    update();
  }

  void enableNotification(bool value) async{
    preferenceHelper.setActiveNotification(value);
    _getIsNotification();
  } 

  Future<bool> scheduledRestaurant(bool value) async {
    if (_isScheduled) {
      print('Scheduling Restaurant Activated');
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
      print('Scheduling Restaurant Canceled');
      update();
      return await AndroidAlarmManager.cancel(1);
    }
  }

}