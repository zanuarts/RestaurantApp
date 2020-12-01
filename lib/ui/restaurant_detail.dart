import 'package:flutter/material.dart';
import 'package:restaurant_app/models/models.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurants;

  const RestaurantDetailPage({@required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurants.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(restaurants.pictureId),
            Text(restaurants.name),
            Text(restaurants.city),
            Text(restaurants.description),
            
          ],
        ),
      ),
    );
  }
}