import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daily_shop/providers/products.dart';

class UserProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (context, index) {
            return Text(index.toString());
          }
        )
      ),
    );
  }
}
