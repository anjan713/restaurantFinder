import 'package:flutter/material.dart';
import 'package:restrofav/Bloc/bloc_provider.dart';
import 'package:restrofav/Bloc/favourite_bloc.dart';
import 'package:restrofav/DataLayer/restaurant.dart';
import 'package:restrofav/UI/restaurantTile.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 final bloc = BlocProvider.of<FavouriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: StreamBuilder(
        stream:  bloc.favouriteRes,
        initialData: bloc.favorites,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          List<Restaurant> favourites = 
          (snapshot.connectionState == ConnectionState.waiting) ? bloc.favorites : snapshot.data ;

          if (favourites == null || favourites.isEmpty) {
            return Center(child:Text('No Favourites'));
            
          }
          return ListView.separated(itemBuilder: (context,index){
            final restaurant = favourites[index];
            return RestaurantTile(restaurant : restaurant);
          }, 
          separatorBuilder:(context,index)=> Divider(), 
          itemCount: favourites.length);

        },
      ),
    );
  }
}
