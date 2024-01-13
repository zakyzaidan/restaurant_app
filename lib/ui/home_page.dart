import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/controllers/restaurant_controller.dart';
import 'package:restaurant_app/ui/widget/build_card.dart';

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
                          return buildCard(context, index);
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
}
