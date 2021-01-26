import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/search_model.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search';

  final RestoSearch restoSearch;

  const RestaurantSearchPage({Key key, this.restoSearch}) : super(key: key); 

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushNamed(context, RestaurantListPage.routeName);
          },
        ),
        title: Text(
          'Search Result'
        ),
      ),
      body: SafeArea(
        child: Center(child: Text('Congrats, you are in search page!'),),
      ),      
    );
  }
}