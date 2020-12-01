import 'package:flutter/material.dart';
import 'package:restaurant_app/models/models.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/json/local_restaurant.json'),
        builder: (context, snapshot){
          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index){
              return _buildRestaurantItem(context, restaurants[index]);
            }
          );
        },
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant){
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    leading: Image.network(
      restaurant.pictureId,
      width: 100,
    ),
    title: Text(restaurant.name),
    subtitle: Text(restaurant.city),
    onTap: (){},
  );
}