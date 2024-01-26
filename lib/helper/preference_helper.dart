import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {

  static const String activeNotif = 'active';

  Future<bool> get isActiveNotification async{
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(activeNotif) ?? false;
  }

  void setActiveNotification(bool value) async{
    final pref = await SharedPreferences.getInstance();
    pref.setBool(activeNotif, value);
  }
}