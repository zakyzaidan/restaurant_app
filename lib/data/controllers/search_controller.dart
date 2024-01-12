import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class SearchQueryController extends GetxController{
  late ApiService apiService;
  late ResultState _state;
  Search? _searchResult;
  TextEditingController searchQuery = TextEditingController();
  String _message = '';

  SearchQueryController({required this.apiService}){
    getSearch(searchQuery.text);
  }

  ResultState get state =>_state;
  String get message => _message;
  Search? get searchResult => _searchResult;


  Future<dynamic> getSearch(String id) async{
    try{
      _state = ResultState.loading;
      update();
      final searchResult = await apiService.getSearchQuery(searchQuery.text);
      if(searchResult.restaurants.isEmpty){
        _state = ResultState.noData;
        update();
        return _searchResult = searchResult;
      }else{
        _state = ResultState.hasData;
        update();
        return _searchResult = searchResult;
      }
    }on SocketException{
      _state = ResultState.error;
      update();
      return _message = "No internet connection, please turn on wifi or selular data";
    }catch(e){
      _state = ResultState.error;
      update();
      return _message = "Error detail --> $e";
    }
  }
}