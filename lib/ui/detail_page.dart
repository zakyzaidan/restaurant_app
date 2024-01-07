import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/local_restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final Restaurant data;

  const DetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 350,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: data.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(data.pictureId,
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
                Text(data.name,
                style: Theme.of(context).textTheme.displayMedium),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    Text(data.city,
                    style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text(data.rating.toString(),
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
                Text(data.description,
                    style: Theme.of(context).textTheme.titleMedium),
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
                      Expanded(child: _CardDrinks(menu: data.menus)),
                      const SizedBox(width: 10),
                      Expanded(child: _CardFoods(menu: data.menus)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CardDrinks extends StatefulWidget {
  final Menus menu;
  const _CardDrinks({Key? key, required this.menu});

  @override
  State<_CardDrinks> createState() => _CardDrinksState();
}

class _CardDrinksState extends State<_CardDrinks> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isShow = !isShow;
        });
      },
      child: isShow ? 
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
          ...widget.menu.drinks.map<Widget>((e){
            return Row(
              children: [
                const Flexible(child:Icon(Icons.chevron_right)),
                Expanded(child: Text(e.name)),
              ],
            );
          }),
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
    );
  }
}


class _CardFoods extends StatefulWidget {
  final Menus menu;
  const _CardFoods({Key? key, required this.menu});

  @override
  State<_CardFoods> createState() => _CardFoodsState();
}

class _CardFoodsState extends State<_CardFoods> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isShow = !isShow;
        });
      },
      child: isShow ? 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset("assets/images/foods.jpg",
            height: 100, fit: BoxFit.cover,),
          ),
          Text("Foods",
          style: Theme.of(context).textTheme.titleLarge,),
          const Divider(),
          ...widget.menu.foods.map<Widget>((e){
            return Row(
              children: [
                const Flexible(child: Icon(Icons.chevron_right)),
                Expanded(child: Text(e.name)),
              ],
            );
          }),
          const SizedBox(height: 30)
        ],
      )
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset("assets/images/foods.jpg",
            ),
          ),
          Text("Foods",
          style: Theme.of(context).textTheme.titleLarge,),
          const Divider(),
          const SizedBox(height: 30)
        ],
      )
    );
  }
}
