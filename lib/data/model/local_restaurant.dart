import 'dart:convert';

// class Menus{
//   final String foods;
//   final String drinks;

//   Menus({
//     required this.foods,
//     required this.drinks
//   });

//   factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
//     foods: menus['foods'],
//     drinks: menus['drinks']
//   );
// }

// class LocalRestaurant{
//   final String id;
//   final String name;
//   final String description;
//   final String pictureId;
//   final String city;
//   final String rating;
//   final Map<String, List<Map<String, String>>> menus;

//   LocalRestaurant({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.pictureId,
//     required this.city,
//     required this.rating,
//     required this.menus,
//   });

//   factory LocalRestaurant.fromJson(Map<String, dynamic> restaurant) => LocalRestaurant(
//         id: restaurant['id'],
//         name: restaurant['name'],
//         description: restaurant['description'],
//         pictureId: restaurant['pictureId'],
//         city: restaurant['city'],
//         rating: restaurant['rating'].toString(),
//         menus: //restaurant['menus'].map((json) => Menus.fromJson(json))
//         {
//           'foods': List<Map<String, String>>.from(restaurant['menus']['foods']),
//           'drinks': List<Map<String, String>>.from(restaurant['menus']['drinks']),
//         },
//       );
// }

// List<LocalRestaurant> parseRestaurants(String? json) {
//   if (json == null) {
//     return [];
//   }

//   final Map<String, dynamic> data = jsonDecode(json);
//   final List<dynamic> restaurantsData = data['restaurants'];

//   return restaurantsData
//       .map((restaurantJson) => LocalRestaurant.fromJson(restaurantJson))
//       .toList();
// }

// void main() async{
//   List restaurants = await parseRestaurants('assets/local_restaurant.json');
//   for (localRestaurant restaurant in restaurants) {
//     print('Restaurant Name: ${restaurant.name}');
//     print('City: ${restaurant.city}');
//     print('Rating: ${restaurant.rating}');
//     print('Menus:');
//     print('  Foods: ${restaurant.menus['foods']}');
//     print('  Drinks: ${restaurant.menus['drinks']}');
//     print('---');
//   }
// }

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'].toDouble(),
        menus: Menus.fromJson(restaurant['menus']),
      );
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods: (menus['foods'] as List<dynamic>)
            .map((food) => Food.fromJson(food))
            .toList(),
        drinks: (menus['drinks'] as List<dynamic>)
            .map((drink) => Drink.fromJson(drink))
            .toList(),
      );
}

class Food {
  final String name;

  Food({
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> food) => Food(
        name: food['name'],
      );
}

class Drink {
  final String name;

  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> drink) => Drink(
        name: drink['name'],
      );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> data = jsonDecode(json);
  final List<dynamic> restaurants = data['restaurants'];

  return restaurants.map((restaurant) => Restaurant.fromJson(restaurant)).toList();
}

// List<LocalRestaurant> parseRestaurants(String? json) {
//   if (json == null) {
//     return [];
//   }

//   final Map<String, dynamic> data = jsonDecode(json);
//   final List<dynamic> restaurantsData = data['restaurants'];

//   return restaurantsData
//       .map((restaurantJson) => LocalRestaurant.fromJson(restaurantJson))
//       .toList();
// }
