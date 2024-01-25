
import 'package:get/get.dart';

class NavigationBarController extends GetxController{
  var tabIndex = 0.obs;

  void changeTabIndex(int i){
    tabIndex.value = i;
  }
}