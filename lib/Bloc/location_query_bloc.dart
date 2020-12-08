import 'dart:async';

import 'package:restrofav/Bloc/bloc.dart';
import 'package:restrofav/DataLayer/location.dart';
import 'package:restrofav/DataLayer/zomato_client.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();

  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
