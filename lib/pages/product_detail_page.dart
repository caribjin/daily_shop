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
      // appBar: AppBar(title: Text(product.title)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                SizedBox(height: 1000),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
