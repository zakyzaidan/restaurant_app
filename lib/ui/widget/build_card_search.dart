import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/controllers/search_controller.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

InkWell buildCardSearch(BuildContext context, int index) {
    final SearchQueryController restaurantC = Get.find();
    Search? localRestaurant = restaurantC.searchResult;

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
                  child: Image.network('https://restaurant-api.dicoding.dev/images/small/'
                  +localRestaurant.restaurants[index].pictureId,
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
            )
          ],
        ),
      ),
    );
  }