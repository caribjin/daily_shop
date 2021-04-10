import 'package:flutter/material.dart';
import 'package:daily_shop/pages/user_product_item.dart';
import 'package:provider/provider.dart';

import 'package:daily_shop/providers/products.dart';
import 'package:daily_shop/providers/product.dart';

class UserProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products productsData = Provider.of<Products>(context);
    final List<Product> products = productsData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/edit-product');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) {
            return Column(
              children: [
                Container(
                  child: UserProductItem(product: products[index]),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
