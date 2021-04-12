import 'package:daily_shop/providers/products.dart';
import 'package:flutter/material.dart';

// import 'package:daily_shop/widgets/product_item.dart';
import 'package:daily_shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';

// import '../dummy_data.dart';

class ProductsOverviewPage extends StatefulWidget {
  final ProductsFilter _filter;

  ProductsOverviewPage(this._filter);

  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchItems().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ProductsGrid(widget._filter);
  }
}
