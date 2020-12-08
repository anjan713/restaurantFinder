import 'package:flutter/material.dart';
import 'package:restrofav/Bloc/bloc_provider.dart';
import 'package:restrofav/Bloc/location_bloc.dart';
import 'package:restrofav/DataLayer/location.dart';
import 'package:restrofav/UI/restaurant_Screen.dart';
import 'location_Screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
        stream: BlocProvider.of<LocationBloc>(context).locationStream,
        builder: (context, snapshot) {
          final location = snapshot.data;
          if (location == null) {
            return LocationScreen();
          }
          return RestaurantScreen(location: location);
        });
  }
}
