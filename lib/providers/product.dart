import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Product.fromMap(Map<String, dynamic> mapData)
      : id = mapData['id'],
        title = mapData['title'],
        description = mapData['description'],
        price = mapData['price'],
        imageUrl = mapData['imageUrl'],
        isFavorite = mapData['isFavorite'];

  void toggleFavoriteState() {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
  }

  Map<String, dynamic>toJson({bool includeId = true}) {
    var result = {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };

    if (includeId) result['id'] = id;

    return result;
  }
}
