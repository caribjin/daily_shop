import 'dart:io';

import 'package:daily_shop/helpers/db_helper.dart';
import 'package:daily_shop/models/place.dart';
import 'package:flutter/material.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) async {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
    );

    _items.add(newPlace);
    notifyListeners();

    await DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData('places');

    _items = data.map((place) {
      return Place(
        id: place['id'],
        title: place['title'],
        image: File(place['image']),
        location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
      );
    }).toList();

    notifyListeners();
  }
}
