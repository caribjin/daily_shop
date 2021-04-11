import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

// https://avatars.githubusercontent.com/u/229460?v=4

enum ProductsFilter {
  All,
  OnlyFavorite,
}

const productsEndpoint = 'https://dailyshop-5ccfc-default-rtdb.firebaseio.com/products.json';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchItems() async {
    final response = await http.get(Uri.parse(productsEndpoint));
    final data = json.decode(response.body) as Map<String, dynamic>;

    data.forEach((id, data) {
      _items.add(Product.fromMap({
        'id': id,
        ...data
      }));
    });

    notifyListeners();
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
      final response = await http.post(Uri.parse(productsEndpoint), body: json.encode(product.toJson(includeId: false)));

      product.id = json.decode(response.body)['name'];
      _items.add(product);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateItem(String id, Product product) async {
    try {
      await http.put(Uri.parse(productsEndpoint + '/' + id), body: json.encode(product.toJson()));
      Product targetProduct = findById(id);
      targetProduct = product;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteItem(String id) async {
    Product targetProduct = findById(id);

    try {
      await http.delete(Uri.parse(productsEndpoint + '/' + id), body: json.encode(targetProduct.toJson()));
      _items.remove(targetProduct);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
