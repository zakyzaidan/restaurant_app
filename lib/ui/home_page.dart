import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/controllers/restaurant_controller.dart';
import 'package:restaurant_app/data/controllers/search_controller.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';

class HomePage extends StatelessWidget {
  final listR = Get.put(RestaurantController(apiService: ApiService()));
  final SearchQueryController searchController = Get.put(SearchQueryController(apiService: ApiService()));
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusManager.instance.primaryFocus?.unfocus();},
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                    color: secondaryColor
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hii, Welcome!",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary
                        ),
                        selectionColor: primaryColor,),
                        const SizedBox(height: 5,),
                        Text("Explore all the restaurant",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary
                        ),),
                        const SizedBox(height: 10,),
                        TextField(
                          controller: searchController.searchQuery,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Search any restaurant or foods here...",
                            hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                            suffixIcon: IconButton(
                              onPressed: (){
                                searchController.getSearch(searchController.searchQuery.text);
                                Get.toNamed("/search");
                              }, 
                              icon: const Icon(Icons.search))
                          ),
                          onEditingComplete: (){
                            searchController.getSearch(searchController.searchQuery.text);
                            Get.toNamed("/search");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Recomendation for you",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              Get.toNamed("/recomendation");
                            }, 
                            child: Text("View all",
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: tertiaryColor
                            ),))
                        ],
                      ),
                      const SizedBox(height: 5,),
                      SizedBox(
                        height: 250,
                        child: GetBuilder<RestaurantController>(
                          init: listR,
                          builder: (_){
                            var state = listR.state;
                            if (state == ResultState.loading){
                              return const Center(child: CircularProgressIndicator());
                            }else if (state == ResultState.hasData && listR.listResult != null){
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                itemBuilder: (context, index){
                                  return buildCardHome(context, index);
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
                      ),
                      Text(
                        "Categories",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
  
  Widget buildCardHome(BuildContext context, int index) {
    final RestaurantController restaurantC = Get.find();
    PurpleList? localRestaurant = restaurantC.listResult;

    return InkWell(
      onTap: (){
         Get.toNamed("/detail", arguments: localRestaurant!.restaurants[index].id);
      },
      child: Container(
        height: 200,
        width: 170,
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network('https://restaurant-api.dicoding.dev/images/small/${listR.listResult!.restaurants[index].pictureId}',
              height: 150,
              fit: BoxFit.fill,),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listR.listResult!.restaurants[index].name,
                  style: Theme.of(context).textTheme.labelSmall,),
                  Row(
                      children: [
                        const Icon(Icons.location_on),
                        Text(listR.listResult!.restaurants[index].city,
                        style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(listR.listResult!.restaurants[index].rating.toString(),
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