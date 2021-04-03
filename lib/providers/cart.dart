import 'package:daily_shop/providers/product.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = Map();

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }
  
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      items.update(product.id, (oldCartItem) => CartItem(
        id: oldCartItem.id,
        product: oldCartItem.product,
        quantity: oldCartItem.quantity + 1,
      ));
    } else {
      _items.putIfAbsent(product.id, () => CartItem(
        id: DateTime.now().toString(),
        product: product,
        quantity: 1
      ));
    }

    notifyListeners();
  }
}

