import 'package:daily_shop/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daily_shop/providers/cart.dart' show Cart;
import 'package:daily_shop/widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cartData = Provider.of<Cart>(context);
    final cartItems = cartData.items.values.toList();

    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Chip(
                  label: Text('\$${cartData.totalAmount.toStringAsFixed(2)}'),
                  backgroundColor: Theme.of(context).primaryColor,
                  labelStyle: TextStyle(color: Theme.of(context).primaryTextTheme.headline6?.color),
                ),
                TextButton(
                  child: Text('ORDER NOW'),
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addItem(cartItems, cartData.totalAmount);
                    cartData.clear();
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: cartData.itemCount,
            itemBuilder: (context, index) {
              return CartItem(
                cartItems[index].id,
                cartItems[index].product.id,
                cartItems[index].product.title,
                cartItems[index].product.price,
                cartItems[index].quantity,
              );
            },
          ),
        ),
      ],
    );
  }
}
