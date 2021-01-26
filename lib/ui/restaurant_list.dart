import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/resto_bloc/resto_bloc.dart';
import 'package:restaurant_app/blocs/resto_bloc/resto_event.dart';
import 'package:restaurant_app/blocs/resto_bloc/resto_state.dart';
import 'package:restaurant_app/blocs/search_bloc/search_bloc.dart';
import 'package:restaurant_app/blocs/search_bloc/search_event.dart';
import 'package:restaurant_app/blocs/search_bloc/search_state.dart';
import 'package:restaurant_app/data/models/resto_model.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_bloc.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_event.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_state.dart';
import 'package:restaurant_app/ui/restaurant_search.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  RestoBloc _restoBloc = RestoBloc();
  // ignore: close_sinks
  DetailBloc _detailBloc = DetailBloc(); // ieu rada acak acakan keneh kekw ngan sahenteuna jalan
  // lamun teu ditutup sink na bakal memory leak moal?
  SearchBloc _searchBloc = SearchBloc();


  TextEditingController _controller;
  
  @override
  void initState() {
    _restoBloc.add(GetRestoList());
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          BlocProvider(
              create: (context) => _searchBloc,
              child: BlocListener<SearchBloc, SearchState>(
                listener: (context, state) {
                  if (state is SearchLoaded) {
                    Navigator.pushNamed(context, RestaurantSearchPage.routeName,
                        arguments: state.search);
                  }
                },
                child: Container(),
              ),
            ),
          BlocProvider(
              create: (context) => _detailBloc,
              child: BlocListener<DetailBloc, DetailState>(
                listener: (context, state) {
                  if (state is DetailLoaded) {
                    Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                        arguments: state.detail);
                  }
                },
                child: Container(),
              ),
            ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              controller: _controller,
              onSubmitted: (String value) async{
                getSearchValue(value, _searchBloc);
              },
            ),
          ),
          Expanded(
            child: BlocProvider(
              create: (_) => _restoBloc,
              child: BlocListener<RestoBloc, RestoState>(
                listener: (context, state) {
                  if (state is RestoError) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)));
                  }
                },
                child: BlocBuilder<RestoBloc, RestoState>(
                  builder: (context, state) {
                    print('check state');
                    if (state is RestoInitial) {
                      print('check state 1');
                      return _buildLoading();
                    } else if (state is RestoLoading) {
                      print('check state 2');
                      return _buildLoading();
                    } else if (state is RestoLoaded) {
                      print('check state 3');
                      return _buildListResto(state.resto, _detailBloc);
                    } else if (state is RestoError) {
                      print('check state 4');
                      return _buildError();
                    }
                  },
                ),
              ),
            ),
          ),
        ])
      ),
    );
  }
}

Widget getSearchValue(String value, SearchBloc _searchBloc){
  _searchBloc.add(GetSearchList(value));
}

void getRestaurantDataFromAPI(String id, DetailBloc _detailBloc) {
  _detailBloc.add(GetDetailList(id));
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

Widget _buildListResto(Resto resto, DetailBloc _detailBloc) {
  return ListView.builder(
    itemCount: resto.restaurants.length,
    itemBuilder: (context, index) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading:
            Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${resto.restaurants[index].pictureId}',
                width: 100,
                fit: BoxFit.fitWidth,
              ),
            ),
        title: Text(
          resto.restaurants[index].name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text(resto.restaurants[index].city),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star_rate_rounded,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text(
                  resto.restaurants[index].rating.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),

            // didieu ngecek mun data detail restaurant na geus aya kakara pindah page
            
          ],
        ),
        onTap: () {
          // manggil bloc detail supaya bisa menang data detail Restaurant
          getRestaurantDataFromAPI(resto.restaurants[index].id, _detailBloc);
        },
      );
    },
  );
}
