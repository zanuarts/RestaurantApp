import 'package:flutter/material.dart';
import 'package:restaurant_app/models/models.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled){
          return[
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.only(top: 70, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Restaurant',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 8),
                      Text('Recommended Restaurant for you!')
                    ],
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
            )
          ];
        },
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
              ) ,
            ),
            Expanded(
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context).loadString('assets/json/local_restaurant.json'),
                builder: (context, snapshot){
                  final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
                  return restaurants.length != 0
                  ? ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index){
                        return _buildRestaurantItem(context, restaurants[index]);
                      }
                    )
                  : Center(
                    child: Text('There is no data!'),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant){
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    leading: Hero(
      tag: restaurant.pictureId,
      child: Container(
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8)
        ),
        child: Image.network(
          restaurant.pictureId,
          width: 100,
          fit: BoxFit.fitWidth,
        ),
      )
    ),
    title: Text(
      restaurant.name,
      style: Theme.of(context).textTheme.headline6,
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height:4),
        Row(
          children: [
            Icon(Icons.location_on_rounded,
              size: 18,
            ),
            SizedBox(width:4),
            Text(restaurant.city),
          ],
        ),
        SizedBox(height:4),
        Row(
          children: [
            Icon(Icons.star_rate_rounded, size: 18,),
            SizedBox(width:4),
            Text(restaurant.rating, style: Theme.of(context).textTheme.bodyText2,)
          ],
        ),
      ],
    ),
    onTap: (){
      Navigator.pushNamed(context, RestaurantDetailPage.routeName, arguments: restaurant);
    },
  );
}