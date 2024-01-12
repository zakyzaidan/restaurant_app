import 'dart:io';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class DetailController extends GetxController{
  late ApiService apiService;
  late ResultState _state;
  Detail? _detailResult;
  String id;
  String _message = '';
  var isShowFoods = false.obs;
  var isShowDrinks = false.obs;

  Detail? get detailResult => _detailResult;
  ResultState get state =>_state;
  String get message =>_message;

  DetailController({required this.id, required this.apiService}){
    _getDetail(id);
  }

  Future<dynamic> _getDetail(String id) async{
    try{
      _state = ResultState.loading;
      update();
      final detailResult = await apiService.getDetail(id);
      if(detailResult.restaurant.id.isEmpty){
        _state = ResultState.noData;
        update();
        return _message = "empty data";
      }else{
        _state = ResultState.hasData;
        update();
        return _detailResult = detailResult;
      }
    } on SocketException{
      _state = ResultState.error;
      update();
      return _message = "No internet connection, please turn on wifi or selular data";
    }catch(e){
      _state = ResultState.error;
      update();
      return _message = "Error detail --> $e";
    }
  }

  void showMenuDrinks(){
    isShowDrinks.value = !isShowDrinks.value;
    update();
  }
  void showMenuFoods(){
    isShowFoods.value = !isShowFoods.value;
    update();
  }
}