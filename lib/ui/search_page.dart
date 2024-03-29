import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/controllers/favoritedb_controller.dart';
import 'package:restaurant_app/data/controllers/search_controller.dart';
import 'package:restaurant_app/ui/widget/build_card_search.dart';

class SearchPage extends StatelessWidget {
  final SearchQueryController searchController = Get.put(SearchQueryController(apiService: ApiService()));
  final FavoriteDbController dbController = Get.put(FavoriteDbController());

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchQueryController>(
        init: searchController,
        builder: (_) {
          var state = searchController.state;
          if (state == ResultStateSearch.loading){
            return const Center(child: CircularProgressIndicator());
          }else if(state == ResultStateSearch.hasData){
            return buildSearchResult(context);
          }else if(state == ResultStateSearch.noData){
            return buildSearchResultNothing(context);
          }else if(state == ResultStateSearch.error){
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

  SafeArea buildSearchResultNothing(BuildContext context) {
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
                  hintStyle: Theme.of(context).textTheme.titleMedium,
                  suffixIcon: IconButton(
                    onPressed: ()=>searchController.getSearch(searchController.searchQuery.text), 
                    icon: const Icon(Icons.search))
                ),
                onEditingComplete: ()=>searchController.getSearch(searchController.searchQuery.text),
              ),
              Expanded(
                child: Center(
                        child: Text("Pencarian anda tidak ditemukan",
                        style: Theme.of(context).textTheme.displaySmall,),
                      )
                ),
            ],
          ),
        ),
      );
  }

  SafeArea buildSearchResult(BuildContext context) {
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
                onEditingComplete: ()=>searchController.getSearch(searchController.searchQuery.text),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on),
                  Text(
                    "${searchController.searchResult!.founded.toString()} Restaurant found"
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                          itemCount: searchController.searchResult!.founded,
                          itemBuilder:(_,index){
                            return buildCardSearch(context, index);
                          },
                        )
                ),
            ],
          ),
        ),
      );
  }
}