import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

// https://avatars.githubusercontent.com/u/229460?v=4

enum ProductsFilter {
  All,
  OnlyFavorite,
}

class Products with ChangeNotifier {
  final String authToken;

  List<Product> _items = [];

  Products(this.authToken, this._items);

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchItems() async {
    try {
      final response = await http.get(makeProductEndpointUri());

      if (response.body == 'null') return;

      final data = json.decode(response.body) as Map<String, dynamic>;
      List<Product> newProducts = [];

      data.forEach((id, data) {
        newProducts.add(Product.fromMap({
          'id': id,
          ...data
        }));
      });

      _items = newProducts;

      notifyListeners();
    } catch(error) {
      throw error;
    }
  }

  List<Product> getFilteredItems(ProductsFilter filter) {
    if (filter == ProductsFilter.OnlyFavorite) {
      return _items.where((item) => item.isFavorite).toList();
    }

    return this.items;
  }

  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  int findIndexById(String id) {
    return _items.indexWhere((p) => p.id == id);
  }

  Future<void> addItem(Product product) async {
    try {
      final response = await http.post(makeProductEndpointUri(), body: json.encode(product.toJson(includeId: false)));

      product.id = json.decode(response.body)['name'];
      _items.add(product);

      notifyListeners();
    } catch(error) {
      throw error;
    }
  }

  Future<void> updateItem(String id, Product product) async {
    try {
      await http.put(makeProductEndpointUri(id), body: json.encode(product.toJson(includeId: false)));
      Product targetProduct = findById(id);
      targetProduct = product;

      notifyListeners();
    } catch(error) {
      throw error;
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await http.delete(makeProductEndpointUri(id));
      Product targetProduct = findById(id);
      _items.remove(targetProduct);

      notifyListeners();
    } catch(error) {
      throw error;
    }
  }

  Uri makeProductEndpointUri([String id = '']) {
    const productsEndpoint = 'https://dailyshop-5ccfc-default-rtdb.firebaseio.com/products';
    final format = '.json?auth=$authToken';

    if (id.isNotEmpty) id = '/$id';

    return Uri.parse('$productsEndpoint$id$format');
  }
}
