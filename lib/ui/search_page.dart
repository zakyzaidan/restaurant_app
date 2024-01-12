import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';
import 'package:restaurant_app/data/controllers/search_controller.dart';

class SearchPage extends StatelessWidget {
  final SearchQueryController searchController = Get.put(SearchQueryController(apiService: ApiService()));

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchQueryController>(
        init: searchController,
        builder: (_) {
          var state = searchController.state;
          if (state == ResultState.loading){
            return const Center(child: CircularProgressIndicator());
          }else if(state == ResultState.hasData){
            return BuildSearchResult(context);
          }else if(state == ResultState.noData){
            return BuildSearchResultNothing(context);
          }else if(state == ResultState.error){
            return Center(
              child: Material(
                child: Text(searchController.message)),
              );
          }else{
            return const Center(
              child: Material(
                child: Text("---------Error---------")),
              );
          }
        }
      ),
    );
  }

  SafeArea BuildSearchResultNothing(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    onPressed: ()=> Get.back(), 
                    icon: const Icon(Icons.arrow_back)),
                  Text(
                    "Find Menu or Restaurant",
                    style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: searchController.searchQuery,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  hintText: "Type here ...",
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  suffixIcon: IconButton(
                    onPressed: ()=>searchController.getSearch(searchController.searchQuery.text), 
                    icon: const Icon(Icons.search))
                ),
              ),
              Expanded(
                child: Center(
                        child: Text("Pencarian anda tidak ditemukan",
                        style: Theme.of(context).textTheme.displayMedium,),
                      )
                ),
            ],
          ),
        ),
      );
  }

  SafeArea BuildSearchResult(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    onPressed: ()=> Get.back(), 
                    icon: const Icon(Icons.arrow_back)),
                  Text(
                    "Find Menu or Restaurant",
                    style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: searchController.searchQuery,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  hintText: "Type here ...",
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  suffixIcon: IconButton(
                    onPressed: ()=>searchController.getSearch(searchController.searchQuery.text), 
                    icon: const Icon(Icons.search))
                ),
              ),
              Expanded(
                child: ListView.builder(
                          itemCount: searchController.searchResult!.founded,
                          itemBuilder:(_,index){
                            return _buildCard(context, index);
                          },
                        )
                ),
            ],
          ),
        ),
      );
  }
}


InkWell _buildCard(BuildContext context, int index) {
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
