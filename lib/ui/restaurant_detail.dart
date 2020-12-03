import 'package:flutter/material.dart';
import 'package:restaurant_app/models/models.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurants;
  final Food food;
  final Drink drinks;

  const RestaurantDetailPage({@required this.restaurants, this.food, this.drinks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled){
          return[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: restaurants.pictureId,
                  child: Image.network(
                    restaurants.pictureId,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 30, bottom: 16),
              ),
            )
          ];
        },
        body: ListView(
          padding: const EdgeInsets.all(16),
          children:[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurants.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on
                    ),
                    SizedBox(width: 8),
                    Text(
                      restaurants.city,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'About',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                Text(restaurants.description),
                SizedBox(height: 8),
                Text(
                  'Menu',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 60, left: 8),
                      height: 100,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$food.name',
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 60, left: 8),
                      height: 100,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$drinks.name',
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}