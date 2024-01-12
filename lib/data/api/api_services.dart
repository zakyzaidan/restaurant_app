import "dart:convert";
import "package:http/http.dart" as http;
import "package:restaurant_app/data/model/detail_restaurant.dart";
import "package:restaurant_app/data/model/local_restaurant.dart";
import "package:restaurant_app/data/model/search_restaurant.dart";

class ApiService{
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _list = '/list';

  Future<PurpleList> getList() async {
    final response = await http.get(Uri.parse("$_baseUrl$_list"));
    if(response.statusCode == 200){
      return PurpleList.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load');
    }
  }

  Future<Detail> getDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return Detail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }

  Future<Search> getSearchQuery(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return Search.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search');
    }
  }
}