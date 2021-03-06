import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_bloc.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_event.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_state.dart';
import 'package:restaurant_app/data/models/detail_model.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

import '../data/models/detail_model.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final RestoDetail restoDetail; 
  RestaurantDetailPage({Key key, this.restoDetail}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => 
  _RestaurantDetailPageState(Key(restoDetail.restaurant.id)); //insert ID into state class
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Key restaurantId;

  _RestaurantDetailPageState(this.restaurantId);

  DetailBloc _detailBloc = DetailBloc(); 

  @override
  void initState() {
    _detailBloc.add(GetDetailList(widget.restoDetail.restaurant.id));
    super.initState();
  }

  Widget _buildDetail(BuildContext context){
    return Container(
        child: BlocProvider(
          create: (_) => _detailBloc,
          child: BlocListener<DetailBloc, DetailState>(
            listener: (context,state){
              if (state is DetailError) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal mengambil data')));
              }
            },
            child: BlocBuilder<DetailBloc, DetailState>(
              builder: (context, state) {
                print('check state');
                if (state is DetailInitial) {
                  print('check state 1');
                  return _buildLoading();
                } 
                else if (state is DetailLoading) {
                  print('check state 2');
                  return _buildLoading();
                }
                else if (state is DetailLoaded) {
                  print('check state 3');
                  return _buildDetailResto(state.detail);
                }
                else if (state is DetailError) {
                  print('check state 4');
                  return _buildError();
                }
              },
            ),
          ),
        )
      );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushNamed(context, HomePage.routeName);
          },
        ),
        title: Text(
          widget.restoDetail.restaurant.name
        ),
      ),
      body: _buildDetail(context)
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pushNamed(context, HomePage.routeName);
          },
        ),
        middle: Text(
          widget.restoDetail.restaurant.name
        ),
      ),
      child: _buildDetail(context)
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget _buildError() {
    return Center(
      child: Text(
        "Tidak ada koneksi internet"
      ),
    );
  }

  Widget _buildDetailResto(RestoDetail detail) {
    return ListView( 
      children: [
          Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/medium/${widget.restoDetail.restaurant.pictureId}',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
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
                  SizedBox(width: 12),
                  Icon(Icons.star),
                  SizedBox(width: 8),
                  Text(
                    widget.restoDetail.restaurant.rating,
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
                ),
                SizedBox(height: 8),
                Text(
                  'Review',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                for (var review in widget.restoDetail.restaurant.customerReviews)
                  Card(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text(review.name),
                          subtitle: Text(review.date + "\n" + review.review),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          )    
        ],
      ),
    ]);
  }
}
