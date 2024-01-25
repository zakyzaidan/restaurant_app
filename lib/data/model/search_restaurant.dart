// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
    bool error;
    int founded;
    List<RestaurantSearch> restaurantSearch;

    Search({
        required this.error,
        required this.founded,
        required this.restaurantSearch,
    });

    factory Search.fromJson(Map<String, dynamic> json) => Search(
        error: json["error"],
        founded: json["founded"],
        restaurantSearch: List<RestaurantSearch>.from(json["restaurants"].map((x) => RestaurantSearch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurantSearch.map((x) => x.toJson())),
    };
}

class RestaurantSearch {
    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    RestaurantSearch({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}
