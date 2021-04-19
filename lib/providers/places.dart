import 'dart:io';

import 'package:daily_shop/models/place.dart';
import 'package:flutter/material.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
    );

    _items.add(newPlace);

    notifyListeners();
  }
}
