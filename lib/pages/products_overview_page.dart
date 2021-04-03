import 'package:daily_shop/providers/products.dart';
import 'package:flutter/material.dart';

// import 'package:daily_shop/widgets/product_item.dart';
import 'package:daily_shop/widgets/products_grid.dart';

// import '../dummy_data.dart';

class ProductsOverviewPage extends StatelessWidget {
  final ProductsFilter _filter;

  ProductsOverviewPage(this._filter);

  @override
  Widget build(BuildContext context) {
    return ProductsGrid(_filter);
  }
}

