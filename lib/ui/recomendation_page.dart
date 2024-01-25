import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/controllers/db_controller.dart';
import 'package:restaurant_app/data/controllers/restaurant_controller.dart';
import 'package:restaurant_app/ui/widget/build_card.dart';

class RecomendationPage extends StatelessWidget {
  final listR = Get.put(RestaurantController(apiService: ApiService()));  
  final DbController dbController = Get.put(DbController());

  RecomendationPage({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: secondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                            children: [
                              IconButton(
                                onPressed: ()=> Get.back(), 
                                icon: const Icon(Icons.arrow_back)),
                              Text(
                                "Recommendation for you!",
                                style: Theme.of(context).textTheme.displaySmall),
                            ],
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                ),
              )
            ],
          ),
    );
  }
}
