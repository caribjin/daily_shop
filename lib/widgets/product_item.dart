import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(
          color: Colors.black87,
          offset: Offset(2, 2),
          blurRadius: 3,
        ),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
            child: GridTile(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
              footer: Container(
                height: 50,
                child: GridTileBar(
                  leading: Consumer<Product>(
                    builder: (context, product, _) => IconButton(
                      iconSize: 20,
                      color: product.isFavorite ? Theme.of(context).accentColor : null,
                      icon: Icon(
                        product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      onPressed: () {
                        product.toggleFavoriteState();
                      },
                    ),
                  ),
                  title: Text(
                    product.title,
                    // textAlign: TextAlign.center,
                  ),
                  subtitle: Text('\$${product.price.toString()}'),
                  trailing: IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {  },
                  ),
                  backgroundColor: Colors.black45,
                ),
              ),
            ),
            onTap: () => Navigator.of(context).pushNamed('/product', arguments: product.id)),
      ),
    );
  }
}
