import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/controllers/favoritedb_controller.dart';
import 'package:restaurant_app/data/controllers/search_controller.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

InkWell buildCardSearch(BuildContext context, int index) {
    final SearchQueryController restaurantC = Get.find();
    FavoriteDbController dbController = Get.find();
    Search? localRestaurant = restaurantC.searchResult;

    return InkWell(
      onTap: () {
        Get.toNamed("/detail", arguments: localRestaurant.restaurantSearch[index].id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Flexible(
              child: Hero(
                tag: localRestaurant!.restaurantSearch[index].id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network('https://restaurant-api.dicoding.dev/images/small/${localRestaurant.restaurantSearch[index].pictureId}',
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
                  Text(localRestaurant.restaurantSearch[index].name,
                  style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(localRestaurant.restaurantSearch[index].city,
                      style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(localRestaurant.restaurantSearch[index].rating.toString(),
                      style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ), 
            GetBuilder(
              init: dbController,
              builder: (_){
                return FutureBuilder(
                  future: dbController.isRestaurantFavById(localRestaurant.restaurantSearch[index].id), 
                  builder: (_, snapshot){
                    var isFavorite = snapshot.data ?? false;
                    return Container(
                      child: isFavorite ?
                      IconButton(
                        onPressed: (){
                          dbController.deleteRestaurantFav(localRestaurant.restaurantSearch[index].id);
                        },
                        icon: const Icon(Icons.favorite),
                      )
                      : IconButton(
                        onPressed: (){
                          dbController.addRestaurantFav(Restaurant(
                            id: localRestaurant.restaurantSearch[index].id, 
                            name: localRestaurant.restaurantSearch[index].name, 
                            description: localRestaurant.restaurantSearch[index].description, 
                            pictureId: localRestaurant.restaurantSearch[index].pictureId, 
                            city: localRestaurant.restaurantSearch[index].city, 
                            rating: localRestaurant.restaurantSearch[index].rating));
                        }, 
                        icon: const Icon(Icons.favorite_border))
                    );
                  });
              }
            )



                // FutureBuilder<bool>(
                //   future: dbController.isRestaurantFavById(localRestaurant.restaurantSearch[index].id), 
                //   builder: (context, snapshot){
                //     var isFavorite = snapshot.data ?? false;
                //     print(isFavorite);
                //     if(!isFavorite){
                //       return IconButton(
                //         onPressed: (){
                //           dbController.addRestaurantFav(Restaurant(
                //             id: localRestaurant.restaurantSearch[index].id, 
                //             name: localRestaurant.restaurantSearch[index].name, 
                //             description: localRestaurant.restaurantSearch[index].description, 
                //             pictureId: localRestaurant.restaurantSearch[index].pictureId, 
                //             city: localRestaurant.restaurantSearch[index].city, 
                //             rating: localRestaurant.restaurantSearch[index].rating));
                //         }, 
                //         icon: const Icon(Icons.favorite_border));
                //     }else{
                //       return IconButton(
                //         onPressed: (){
                //           dbController.deleteRestaurantFav(localRestaurant.restaurantSearch[index].id);
                //         }, 
                //         icon: const Icon(Icons.favorite));
                //     }
                //   }
                // )
          ],
        ),
      ),
    );
  }