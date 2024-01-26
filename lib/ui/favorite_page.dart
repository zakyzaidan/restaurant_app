import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/controllers/favoritedb_controller.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteDbController _dbController = Get.put(FavoriteDbController());
  FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              color: secondaryColor
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("This is your favorite",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary
                  ),
                  selectionColor: primaryColor,),
                  const SizedBox(height: 5,),
                  Text("Explore all the restaurant",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary
                  ),),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder(
              init: _dbController,
              builder: (_){
                if(_dbController.restaurantFav.isEmpty){
                  return const Center(
                    child: Text("Silahkan tambah restaurant favorit anda"),
                  );
                }else{
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: _dbController.restaurantFav.length,
                      itemBuilder: (_, index){
                        return buildCardFavorite(_, index);
                      }
                    ),
                  );
                }
              }
            ),
          )
        ],
      )
    );
  }
}

InkWell buildCardFavorite(BuildContext context, int index) {
    final FavoriteDbController dbController = Get.find();

    return InkWell(
      onTap: () {
        Get.toNamed("/detail", arguments: dbController.restaurantFav[index].id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Flexible(
              child: Hero(
                tag: dbController.restaurantFav[index].id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network('https://restaurant-api.dicoding.dev/images/small/${dbController.restaurantFav[index].pictureId}',
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
                  Text(dbController.restaurantFav[index].name,
                  style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(dbController.restaurantFav[index].city,
                      style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(dbController.restaurantFav[index].rating.toString(),
                      style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ),
            GetBuilder(
              init: dbController,
              builder: (_){
                var restaurant = dbController.restaurantFav[index];
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