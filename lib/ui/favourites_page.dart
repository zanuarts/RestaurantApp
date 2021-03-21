import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class FavouritesPage extends StatelessWidget {
  static const String favouritesTitle = 'Favourites';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favouritesTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(favouritesTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    // return Consumer<DatabaseProvider>(
    //   builder: (context, provider, child) {
    //     if (provider.state == ResultState.HasData) {
    //       return ListView.builder(
    //         itemCount: provider.Favourites.length,
    //         itemBuilder: (context, index) {
    //           return CardArticle(article: provider.Favourites[index]);
    //         },
    //       );
    //     } else {
    //       return Center(
    //         child: Text(provider.message),
    //       );
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}