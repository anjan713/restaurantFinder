import 'package:flutter/material.dart';
import 'package:restrofav/DataLayer/restaurant.dart';
import 'package:restrofav/UI/image_container.dart';
import 'package:restrofav/UI/restaurant_details_screen.dart';

class RestaurantTile extends StatelessWidget {
  Restaurant restaurant;
  RestaurantTile({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) =>
          RestaurantDetailsScreen(restaurant: restaurant),
    ),
  );
},
      leading: ImageContainer(
        url: restaurant.thumbUrl,
        width: 50,
        height: 50,),
        title: Text(restaurant.name),
        trailing: Icon(Icons.keyboard_arrow_right),

    );
  }
}
