import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daily_shop/providers/products.dart';
import 'package:daily_shop/providers/product.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context)?.settings.arguments as String;
    final Product product = Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // buildSectionTitle(context, 'Ingredients'),
            // buildList(context, meal.ingredients ?? []),
            // buildSectionTitle(context, 'Steps'),
            // buildList(context, meal.steps ?? []),
          ],
        ),
      ),
    );
  }
}
