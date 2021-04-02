import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daily_shop/models/products.dart';
import 'package:daily_shop/widgets/product_item.dart';
import 'package:daily_shop/providers/products.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products productsData = Provider.of<Products>(context);
    final List<Product> products = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.0,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return ProductItem(products[index]);
      },
    );
  }
}
