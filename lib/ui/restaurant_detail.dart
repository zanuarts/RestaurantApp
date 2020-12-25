
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/models.dart';

import '../models/models.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurants;


  const RestaurantDetailPage(
      {@required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
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
        body: ListView(padding: const EdgeInsets.all(16), 
        children: [
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
                  Icon(Icons.location_on),
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
                'Foods',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8),

              Container(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var item in restaurants.menus.foods)
                      Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('Card tapped.');
                          print(item.name);
                        },  
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: 140.0,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/fast-food.png', 
                                height: 80,
                                fit: BoxFit.fitHeight
                              ),
                              SizedBox(height: 8),
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 8),
              Text(
                'Drinks',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8),

              Container(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var item in restaurants.menus.drinks)
                      Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('Card tapped.');
                          print(item.name);
                        },  
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: 140.0,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/fast-food.png', 
                                height: 80,
                                fit: BoxFit.fitHeight
                              ),
                              SizedBox(height: 8),
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}