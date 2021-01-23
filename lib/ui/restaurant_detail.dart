
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/detail_model.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  
  final String id;
  
  RestoDetail _restoDetail;
  // Restaurant restaurants;

  RestaurantDetailPage({@required this._restoDetail, this.id}); //still error here

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
                  tag: _restoDetail.restaurant.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${_restoDetail.restaurant.pictureId}',
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
                _restoDetail.restaurant.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 8),
                  Text(
                    _restoDetail.restaurant.city,
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
              Text(_restoDetail.restaurant.description),
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
                    for (var item in _restoDetail.restaurant.menus.foods)
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
                    for (var item in _restoDetail.restaurant.menus.drinks)
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