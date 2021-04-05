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

  double get totalAmount {
    double sum = 0;

    _items.forEach((String key, CartItem cartItem) {
      sum += cartItem.product.price * cartItem.quantity;
    });

    return sum;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (oldCartItem) => CartItem(
          id: oldCartItem.id,
          product: oldCartItem.product,
          quantity: oldCartItem.quantity + 1,
        )
      );
    } else {
      _items.putIfAbsent(product.id, () => CartItem(id: DateTime.now().toString(), product: product, quantity: 1));
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);

    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items.update(productId, (prev) {
        return CartItem(
          id: prev.id,
          product: prev.product,
          quantity: prev.quantity - 1
        );
      });
    } else if (_items[productId]!.quantity == 1) {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
