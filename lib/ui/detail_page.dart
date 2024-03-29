import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/controllers/favoritedb_controller.dart';
import 'package:restaurant_app/data/controllers/detail_controller.dart';
import 'package:restaurant_app/data/controllers/review_controller.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';
import 'package:restaurant_app/ui/widget/card_drinks.dart';
import 'package:restaurant_app/ui/widget/card_foods.dart';

class DetailPage extends StatelessWidget {
  final DetailController _detailController = Get.put(DetailController(id: "${Get.arguments}", apiService: ApiService()));
  final ReviewController _reviewController = Get.put(ReviewController(id: "${Get.arguments}", apiService: ApiService()));
  static const routeName = '/detail';

  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: _detailController,
      builder: (_) {
        var state = _detailController.state;
        if (state == ResultState.loading){
          return const Center(child: CircularProgressIndicator());
        }else if(state == ResultState.hasData){
          return buildDetailPage(context);
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

  Scaffold buildDetailPage(BuildContext context) {
    final FavoriteDbController dbController = Get.put(FavoriteDbController());
    return Scaffold(
    body: Stack(
      children: [
        NestedScrollView(
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
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_detailController.detailResult!.restaurant.name,
                        style: Theme.of(context).textTheme.displayMedium),
                        GetBuilder(
                          init: dbController,
                          builder: (_){
                            var restaurant = _detailController.detailResult!.restaurant;
                            return FutureBuilder(
                              future: dbController.isRestaurantFavById(restaurant.id), 
                              builder: (_, snapshot){
                                var isFavorite = snapshot.data ?? false;
                                return Container(
                                  child: isFavorite ?
                                  IconButton(
                                    onPressed: (){
                                      dbController.deleteRestaurantFav(restaurant.id);
                                    },
                                    icon: const Icon(Icons.favorite),
                                  )
                                  : IconButton(
                                    onPressed: (){
                                      dbController.addRestaurantFav(Restaurant(
                                        id: restaurant.id, 
                                        name: restaurant.name, 
                                        description: restaurant.description, 
                                        pictureId: restaurant.pictureId, 
                                        city: restaurant.city, 
                                        rating: restaurant.rating));
                                    }, 
                                    icon: const Icon(Icons.favorite_border))
                                );
                              });
                          }
                        )
                      ],
                    ),
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
                  const SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Name", style: Theme.of(context).textTheme.titleMedium,),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: TextField(
                                controller: _reviewController.nameController,
                                decoration: InputDecoration(
                                  hintText: "Type your name here ...",
                                  hintStyle: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Text("Review", style: Theme.of(context).textTheme.titleMedium,),
                        TextField(
                              controller: _reviewController.reviewController,
                              decoration: InputDecoration(
                                hintText: "Give some review ...",
                                hintStyle: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                        const SizedBox(height: 5,),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            )
                          ),
                          onPressed: ()=>submit(
                            context,
                            _reviewController.nameController.text,
                            _reviewController.reviewController.text
                          ),
                          child: Text("Submit",style: Theme.of(context).textTheme.bodySmall,)),
                      ],
                    ),
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
      ],
    ),
  );
  }

  void submit(BuildContext context, String nama, String review){
    if(nama.isEmpty || review.isEmpty){
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        content: Text("Isi nama dan review untuk membuat review"),
        backgroundColor: Colors.red,
    );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    _reviewController.postReview(
      '${Get.arguments}', _reviewController.nameController.text, _reviewController.reviewController.text);
    
    _reviewController.nameController.clear();
    _reviewController.reviewController.clear();
    const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        content: Text("Anda berhasil membuat review, silahkan refresh..."),
        backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
