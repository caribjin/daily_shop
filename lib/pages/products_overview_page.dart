import 'package:flutter/material.dart';

// import '../widgets/category_item.dart';
import '../models/products.dart';

import '../dummy_data.dart';

class ProductsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container(
    // child: GridView(
    //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 200,
    //     childAspectRatio: 1.5,
    //     crossAxisSpacing: 20,
    //     mainAxisSpacing: 20,
    //   ),
    //   padding: const EdgeInsets.all(25),
    //   children: dummyProducts.map(
    //     (Product product) {
    //       return Text(product.title);
    //     },
    //   ).toList(),
    // ),
    // );

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      // gridDelegate: gridDelegate,
      itemCount: loadedProducts.length,
      itemBuilder: (context, index) {
        return Text('Item $index');
      },
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.0,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}
