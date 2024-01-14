import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/controllers/detail_controller.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

class CardDrinks extends StatelessWidget {
  CardDrinks({super.key, required this.menu});

  final DetailController dc = Get.find();
  final Menus menu;
  
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => dc.showMenuDrinks(),
        child: dc.isShowDrinks.value ? 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/drinks.jpg",
              height: 100, fit: BoxFit.cover,),
            ),
            Text("Drinks",
            style: Theme.of(context).textTheme.titleLarge,),
            const Divider(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: menu.drinks.length,
              itemBuilder: (_, index){
                return Row(
                  children: [
                    const Flexible(child:Icon(Icons.chevron_right)),
                    Expanded(child: Text(menu.drinks[index].name)),
                  ],
                );
              },
            ),
            const SizedBox(height: 30)
          ],
        )
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/drinks.jpg",
              ),
            ),
            Text("Drinks",
            style: Theme.of(context).textTheme.titleLarge,),
            const Divider(),
            const SizedBox(height: 30)
          ],
        )
      ),
    );
  }
}
