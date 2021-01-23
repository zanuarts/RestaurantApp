import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/detail_model.dart';

import '../data/models/detail_model.dart';

class RestaurantDetailPage extends StatefulWidget {
  // StatefulWidget is mandatory
  static const routeName = '/restaurant_detail';

  final RestoDetail restoDetail; // initialize restoDetail
  RestaurantDetailPage({Key key, this.restoDetail}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState(
      Key(restoDetail.restaurant.id)); //insert ID into state class
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final Key restaurantId;
  _RestaurantDetailPageState(this.restaurantId);
  // now you have the id, do whatever you want kekw

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
                  tag: widget.restoDetail.restaurant.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${widget.restoDetail.restaurant.pictureId}',
                    fit: BoxFit.fitWidth,
                  ),
                  key: Key(widget.restoDetail.restaurant.id),
                ),
                titlePadding: const EdgeInsets.only(left: 30, bottom: 16),
              ),
            )
          ];
        },
        body: ListView(padding: const EdgeInsets.all(16), children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.restoDetail.restaurant.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 8),
                  Text(
                    widget.restoDetail.restaurant.city,
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
              Text(widget.restoDetail.restaurant.description),
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
                    for (var item in widget.restoDetail.restaurant.menus.foods)
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
                              Image.asset('assets/images/fast-food.png',
                                  height: 80, fit: BoxFit.fitHeight),
                              SizedBox(height: 8),
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                      )),
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
                    for (var item in widget.restoDetail.restaurant.menus.drinks)
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
                              Image.asset('assets/images/fast-food.png',
                                  height: 80, fit: BoxFit.fitHeight),
                              SizedBox(height: 8),
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                      )),
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
