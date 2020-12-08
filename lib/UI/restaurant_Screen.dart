import 'package:flutter/material.dart';
import 'package:restrofav/Bloc/bloc_provider.dart';
import 'package:restrofav/Bloc/restaurant_bloc.dart';
import 'package:restrofav/DataLayer/location.dart';
import 'package:restrofav/DataLayer/restaurant.dart';
import 'package:restrofav/UI/favourite_screen.dart';
import 'package:restrofav/UI/restaurantTile.dart';

class RestaurantScreen extends StatelessWidget {
  Location location;
  RestaurantScreen({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('restaurants in ${location.title}'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => FavouriteScreen()));
              })
        ],
      ),
      body: _buildWidget(context),
    );
  }

  Widget _buildWidget(BuildContext context) {
    final bloc = RestaurantBloc(location);
    return BlocProvider(
      bloc: bloc,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What do you want to Eat',
              ),
              onChanged: (query) => bloc.submitquery(query),
            ),
          ),
          Expanded(child: _buildStreamBuilder(bloc)),
        ],
      ),
    );
  }

  Widget _buildStreamBuilder(RestaurantBloc bloc) {
    return StreamBuilder<List<Restaurant>>(
      stream: bloc.recieverestaurants,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final results = snapshot.data;
        if (results == null) {
          return Center(
            child: Text('Enter a restaurant name or cusine type'),
          );
        }
        if (results.isEmpty) {
          return Center(
            child: Text('No Results'),
          );
        }
        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Restaurant> results) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final restaurant = results[index];
          return RestaurantTile(restaurant: restaurant);
        },
        separatorBuilder: (ctx, index) => Divider(),
        itemCount: results.length);
  }
}
