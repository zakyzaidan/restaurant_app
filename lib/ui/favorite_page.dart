import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/controllers/db_controller.dart';
import 'package:restaurant_app/ui/widget/build_card_search.dart';

class FavoritePage extends StatelessWidget {
  final DbController _dbController = Get.put(DbController());
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
                      itemBuilder: (context, index){
                        return buildCardSearch(context, index);
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