import 'dart:async';

import 'package:restrofav/Bloc/bloc.dart';
import 'package:restrofav/DataLayer/location.dart';
import 'package:restrofav/DataLayer/restaurant.dart';
import 'package:restrofav/DataLayer/zomato_client.dart';

class RestaurantBloc implements Bloc {
  Location location;
  final _client = ZomatoClient();
  final _controller = StreamController<List<Restaurant>>();
  RestaurantBloc(this.location);
  Stream<List<Restaurant>> get recieverestaurants => _controller.stream;

  Future<List<Restaurant>> submitquery(String query) async {
    final result = await _client.fetchRestaurants(location, query);
    _controller.sink.add(result);
  }

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
  }
}
