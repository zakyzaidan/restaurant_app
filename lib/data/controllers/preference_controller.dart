import 'package:get/get.dart';
import 'package:restaurant_app/helper/preference_helper.dart';

class PreferenceController extends GetxController{
  PreferenceHelper preferenceHelper;

  PreferenceController({required this.preferenceHelper}){
    _getIsNotification();
  }

  bool _isActiveNotification = false;
  bool get isActiveNotification => _isActiveNotification;

  void _getIsNotification() async{
    _isActiveNotification = await preferenceHelper.isActiveNotification;
    update();
  }

  void enableNotification(bool value) async{
    preferenceHelper.setActiveNotification(value);
    _getIsNotification();
  } 
}