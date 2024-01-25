import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/controllers/db_controller.dart';
import 'package:restaurant_app/data/controllers/restaurant_controller.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';

InkWell buildCard(BuildContext context, int index) {
    final RestaurantController restaurantC = Get.find();
    final DbController dbController = Get.find();
    PurpleList? localRestaurant = restaurantC.listResult;

    return InkWell(
      onTap: () {
        Get.toNamed("/detail", arguments: localRestaurant.restaurants[index].id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Flexible(
              child: Hero(
                tag: localRestaurant!.restaurants[index].id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network('https://restaurant-api.dicoding.dev/images/small/${localRestaurant.restaurants[index].pictureId}',
                  height: 100,
                  width: 150,
                  fit: BoxFit.fill,),
                ),
              )
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localRestaurant.restaurants[index].name,
                  style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(localRestaurant.restaurants[index].city,
                      style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(localRestaurant.restaurants[index].rating.toString(),
                      style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ),
            GetBuilder(
              init: dbController,
              builder: (_){
                var restaurant = localRestaurant.restaurants[index];
                return FutureBuilder(
                  future: dbController.isRestaurantFavById(restaurant.id), 
                  builder: (_, snapshot){
                    var isFavorite = snapshot.data ?? false;
                    return Container(
                      child: isFavorite ?
                      IconButton(
                        onPressed: (){
                          dbController.deleteRestaurantFav(restaurant.id);
                        },
                        icon: const Icon(Icons.favorite),
                      )
                      : IconButton(
                        onPressed: (){
                          dbController.addRestaurantFav(Restaurant(
                            id: restaurant.id, 
                            name: restaurant.name, 
                            description: restaurant.description, 
                            pictureId: restaurant.pictureId, 
                            city: restaurant.city, 
                            rating: restaurant.rating));
                        }, 
                        icon: const Icon(Icons.favorite_border))
                    );
                  });
              }
            )
          ],
        ),
      ),
    );
  }

