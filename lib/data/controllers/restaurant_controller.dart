import 'dart:io';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantController extends GetxController{
  late ApiService apiService;

  RestaurantController({required this.apiService}){
    _fetchAllList();
  }

  PurpleList? _listResult;
  late ResultState _state;
  String _message = '';


  PurpleList? get listResult => _listResult;
  String get message =>_message;
  ResultState get state => _state;


  Future<dynamic> _fetchAllList() async {
    // final list = await apiService.getList();
    // return _listResult = list;
    try{
      _state = ResultState.loading;
      update();
      final listResult = await apiService.getList();
      if(listResult.restaurants.isEmpty){
        _state = ResultState.noData;
        update();
        return _message = "empty data";
      }else{
        _state = ResultState.hasData;
        update();
        return _listResult = listResult;
      }
    }on SocketException{
      _state = ResultState.error;
      update();
      return _message = "No internet connection, please turn on wifi or selular data";
    }catch(e){
      _state = ResultState.error;
      update();
      return _message = "Error --> $e";
    }
  }  
}

