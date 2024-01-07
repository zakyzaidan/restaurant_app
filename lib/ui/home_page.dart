import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
              Expanded(
                child: FutureBuilder(
                  future: DefaultAssetBundle.of(context).loadString("assets/local_restaurant.json"),
                  builder: (context, snapshot){
                    final List<Restaurant> localRestaurant = parseRestaurants(snapshot.data);
                    return ListView.builder(
                      itemCount: localRestaurant.length,
                      itemBuilder: (context, index){
                        return _buildCard(context, localRestaurant, index);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  InkWell _buildCard(BuildContext context, List<Restaurant> localRestaurant, int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: localRestaurant[index]);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Flexible(
              child: Hero(
                tag: localRestaurant[index].pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(localRestaurant[index].pictureId,
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
                  Text(localRestaurant[index].name,
                  style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(localRestaurant[index].city,
                      style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(localRestaurant[index].rating.toString(),
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