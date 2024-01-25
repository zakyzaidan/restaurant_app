

import 'package:get/get.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';
import 'package:restaurant_app/helper/favoritedb_helper.dart';

class DbController extends GetxController{
  List<Restaurant> _restaurantsFav = [];
  late FavoriteDbHelper _dbHelper;

  List<Restaurant> get restaurantFav => _restaurantsFav;

  DbController(){
    _dbHelper = FavoriteDbHelper();
  }

  Future<void> addRestaurantFav(Restaurant restaurant) async{
    await _dbHelper.insertRestaurantFav(restaurant);
    _restaurantsFav = await _dbHelper.getRestaurantFav();
    update();
  }

  Future<bool> isRestaurantFavById(String id) async{
    final isFavorite = await _dbHelper.getRestaurantFavById(id);
    return isFavorite.isNotEmpty;
  }

  void updateRestaurantFav(Restaurant restaurant) async{
    await _dbHelper.updateRestaurantFav(restaurant);
    _restaurantsFav = await _dbHelper.getRestaurantFav();
    update();
  }

  void deleteRestaurantFav(String id) async{
    await _dbHelper.deleteRestaurantFav(id);
    _restaurantsFav = await _dbHelper.getRestaurantFav();
    update();
  }
}