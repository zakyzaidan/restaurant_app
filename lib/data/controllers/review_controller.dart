import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/review_restaurant.dart';

enum ResultStateReview { loading, succeed, error }

class ReviewController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  late ApiService apiService;
  late ResultStateReview _state;
  String id;
  String _message = '';
  Review? _reviewResult;

  ResultStateReview get state =>_state;
  String get message => _message;
  Review? get reviewResult => _reviewResult;

  ReviewController({required this.id, required this.apiService});

  Future<dynamic> postReview(String id, String name, String review) async{
    try{
      _state = ResultStateReview.loading;
      update();

      final reviewResult = await apiService.postReviewRestaurant(id, name, review);
      if(reviewResult.error){
        _state = ResultStateReview.error;
        update();
        return _message = "Sorry, you got error";
      }else{
        _state = ResultStateReview.succeed;
        nameController.clear();
        reviewController.clear();
        update();
        return _reviewResult = reviewResult;
      }
    }on SocketException{
      _state = ResultStateReview.error;
      update();
      return _message = "No internet connection, please turn on wifi or selular data";
    }catch(e){
      _state = ResultStateReview.error;
      update();
      return _message = "Error detail --> $e";
    }
  }
}