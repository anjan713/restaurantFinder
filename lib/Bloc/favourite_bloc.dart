import 'dart:async';

import 'package:restrofav/Bloc/bloc.dart';
import 'package:restrofav/DataLayer/restaurant.dart';

class FavouriteBloc implements Bloc {
  final _myfav = <Restaurant>[];
  List<Restaurant> get favorites => _myfav;
  final _controller = StreamController<List<Restaurant>>.broadcast();

  Stream<List<Restaurant>> get favouriteRes => _controller.stream;

  void toggleRestaurants(Restaurant restaurant) {
    if (_myfav.contains(restaurant)) {
      _myfav.remove(restaurant);
    } else {
      _myfav.add(restaurant);
    }
    _controller.sink.add(_myfav);
  }

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
  }
}
