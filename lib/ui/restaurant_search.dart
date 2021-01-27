import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_bloc.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_state.dart';
import 'package:restaurant_app/blocs/search_bloc/search_bloc.dart';
import 'package:restaurant_app/blocs/search_bloc/search_event.dart';
import 'package:restaurant_app/blocs/search_bloc/search_state.dart';
import 'package:restaurant_app/data/models/search_model.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search';

  final RestoSearch restoSearch;
  
  RestaurantSearchPage({Key key, this.restoSearch}) : super(key: key); 

  @override
  _RestaurantSearchPageState createState() => 
  _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  SearchBloc _searchBloc = SearchBloc();
  DetailBloc _detailBloc = DetailBloc();

  @override
  void initState() {
    // _searchBloc.add(GetSearchList());
    super.initState();
  }
  
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
        // child: Center(child: Text('Congrats, you are in search page!'),),
        child: ListView(
          children: [    
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
            BlocProvider(
              create: (_) => _searchBloc,
              child: BlocListener<SearchBloc, SearchState>(
                listener: (context, state){
                  if (state is SearchError){
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)));
                  };
                },
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state){
                    if (state is SearchInitial){
                      print(state);
                      return _buildLoading();
                    }
                    else if (state is SearchLoading){
                      print(state);
                      return _buildLoading();
                    }
                    else if (state is SearchLoaded){
                      print(state);
                      return _buildResult(state.search, _detailBloc);
                    }
                    else if (state is SearchError){
                      print(state);
                      return _buildError();
                    }
                  },
                ),
              ),
            ),
          ],      
        )
      )
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildError() => Center(child: Text('Failed to load data'));

  Widget _buildResult(RestoSearch restoSearch, DetailBloc _detailBloc){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${widget.restoSearch.founded} hasil ditemukan'), 
        ListView.builder(
          itemCount: restoSearch.restaurants.length,
          itemBuilder: (context, index){
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/medium/${restoSearch.restaurants[index].pictureId}',
                  width: 100,
                  fit: BoxFit.fitWidth,
                ),
              ),
              title: Text(
                restoSearch.restaurants[index].name,
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
                      Text(restoSearch.restaurants[index].city),
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
                        restoSearch.restaurants[index].rating.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ],
              ),
              onTap: () {
                getRestaurantDataFromAPI(restoSearch.restaurants[index].id, _detailBloc);
              },
            );
          },
        )
      ],
    );
  }
}