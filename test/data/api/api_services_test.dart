import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

@GenerateMocks([http.Client])
void main(){
  group('api_services', () {
    test('return all restaurant model if the http call complete successfully', () async{
      final client = MockClient((request) async{
        final response = {
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants":[]
        };
        return http.Response(json.encode(response), 200);
      });

      expect(await ApiService().getList(client), isA<PurpleList>());
    });
  
    test('give search string and return all restaurant with right name or food', ()async{
      //arrange
      const String search = "kafe";
      //act
      final client = MockClient((request)async{
        final response = {
          "error": false,
          "founded": 4,
          "restaurants": []
        };
        return http.Response(json.encode(response), 200);
      });
      //assert
      var result = await ApiService().getSearchQuery(client, search);
      expect(result, isA<Search>());
    });
  });
}