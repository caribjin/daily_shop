import 'package:daily_shop/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Places>(
      builder: (context, placesData, child) {
        if (placesData.items.length <= 0) {
          return child!;
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(placesData.items[index].image),
                  ),
                  title: Text(placesData.items[index].title),
                  subtitle: Text(placesData.items[index].location.address),
                  onTap: () {});
            },
            itemCount: placesData.items.length,
          );
        }
      },
      child: Center(
        child: Text('Got no places yet'),
      ),
    );
  }
}
