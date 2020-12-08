import 'package:flutter/material.dart';
import 'package:restrofav/Bloc/bloc_provider.dart';
import 'package:restrofav/Bloc/location_bloc.dart';
import 'package:restrofav/Bloc/location_query_bloc.dart';
import 'package:restrofav/DataLayer/location.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;
  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
     final bloc = LocationQueryBloc();
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Where do you Want to eat'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a location',
                ),
                onChanged: (query) {
                  bloc.submitQuery(query);
                },
              ),
            ),
            Expanded(
              child: _buildWidget(bloc),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidget(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
      stream: bloc.locationStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(
            child: Text('Enter a location'),
          );
        }
        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }

        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    return ListView.separated(
        separatorBuilder: (ctx, indx) => Divider(),
        itemBuilder: (context, index) {
          final location = results[index];
          return ListTile(
            title: Text(location.title),
            onTap: () {
              final locationBloc = BlocProvider.of<LocationBloc>(context);
              locationBloc.selectLocation(location);

              if (isFullScreenDialog) {
                Navigator.of(context).pop();
              }
            },
          );
        },
        itemCount: results.length);
  }
}
