import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/controllers/restaurant_controller.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  final listR = Get.put(RestaurantController(apiService: ApiService()));
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "Restaurant",
                            style: Theme.of(context).textTheme.displayLarge),
                          Text(
                            "Recommendation restaurant for you!",
                            style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 10)
                        ],
                      ),
                  ),
                  InkWell(
                    onTap: ()=> Get.toNamed("/search"),
                    child: const Icon(
                      Icons.search,
                      size: 50,
                    )
                  )
                ],
              ),
              Expanded(
                child: GetBuilder<RestaurantController>(
                  init: listR,
                  builder: (_){
                    var state = listR.state;
                    if (state == ResultState.loading){
                      return const Center(child: CircularProgressIndicator());
                    }else if (state == ResultState.hasData && listR.listResult != null){
                      return ListView.builder(
                        itemCount: listR.listResult?.count,
                        itemBuilder: (context, index){
                          return _buildCard(context, index);
                        },
                      );
                    } else if (state == ResultState.noData){
                        return Center(
                          child: Material(
                            child: Text(listR.message),
                          ),
                        );
                    } else if (state == ResultState.error){
                        return Center(
                          child: Material(
                            child: Text(listR.message)),
                          );
                    } else{
                      return const Center(
                          child: Material(
                            child: Text("Error---------")),
                          );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  InkWell _buildCard(BuildContext context, int index) {
    final RestaurantController restaurantC = Get.find();
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
                  child: Image.network('https://restaurant-api.dicoding.dev/images/small/'+localRestaurant.restaurants[index].pictureId,
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
}