import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/controllers/detail_controller.dart';
import 'package:restaurant_app/ui/widget/card_drinks.dart';
import 'package:restaurant_app/ui/widget/card_foods.dart';

class DetailPage extends StatelessWidget {
  final DetailController _detailController = Get.put(DetailController(id: "${Get.arguments}", apiService: ApiService()));

  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: _detailController,
      builder: (_) {
        var state = _detailController.state;
        if (state == ResultState.loading){
          return const Center(child: CircularProgressIndicator());
        }else if(state == ResultState.hasData){
          return BuildDetailPage(context);
        }else if(state == ResultState.noData){
          return Center(
              child: Material(
                child: Text(_detailController.message),
              ),
            );
        }else if(state == ResultState.error){
          return Center(
            child: Material(
              child: Text(_detailController.message)),
            );
        }else{
          return const Center(
            child: Material(
              child: Text("---------Error---------")),
            );
        }
      }
    );
  }

  Scaffold BuildDetailPage(BuildContext context) {
    return Scaffold(
    body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            title: Text(
              _detailController.detailResult!.restaurant.name,
              style: Theme.of(context).textTheme.displaySmall
            ),
            leading: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Material(
                type: MaterialType.transparency,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: _detailController,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/${_detailController.detailResult?.restaurant.pictureId}",
                  fit: BoxFit.fill,),
                ),
              ),
            ),
          )
        ];
      },
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: [
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_detailController.detailResult!.restaurant.name,
              style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Icon(Icons.home_work_rounded),
                  Text(_detailController.detailResult!.restaurant.city,
                  style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.location_on),
                  Text(_detailController.detailResult!.restaurant.address,
                  style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  Text(_detailController.detailResult!.restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Description",
              style:  Theme.of(context).textTheme.displaySmall),
              Text(_detailController.detailResult!.restaurant.description,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories",
              style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _detailController.detailResult!.restaurant.categories.length,
                  itemBuilder: (_, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(_detailController.detailResult!.restaurant.categories[index].name,
                          style: Theme.of(context).textTheme.titleMedium,),
                        ),
                      );
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Menu",
              style: Theme.of(context).textTheme.displaySmall),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Expanded(child: CardDrinks(menu: _detailController.detailResult!.restaurant.menus)),
                    const SizedBox(width: 10),
                    Expanded(child: CardFoods(menu: _detailController.detailResult!.restaurant.menus)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Review",
              style:  Theme.of(context).textTheme.displaySmall),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _detailController.detailResult!.restaurant.customerReviews.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: tertiaryColor,
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_detailController.detailResult!.restaurant.customerReviews[index].name,
                                style: Theme.of(context).textTheme.titleMedium,),
                                Text(_detailController.detailResult!.restaurant.customerReviews[index].date,
                                style: Theme.of(context).textTheme.titleSmall,),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0,),
                        Text(_detailController.detailResult!.restaurant.customerReviews[index].review,
                        style: Theme.of(context).textTheme.titleMedium,)
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    ),
  );
  }
}
