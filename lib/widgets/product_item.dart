import 'package:flutter/material.dart';

import '../pages/category_meals_page.dart';
import '../models/products.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.black,
          //   width: 1,
          // ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(2, 2),
              blurRadius: 3,
            ),
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GridTile(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            footer: Container(
              height: 50,
              child: GridTileBar(
                leading: Icon(
                  Icons.favorite,
                  size: 20,
                ),
                title: Text(
                  product.title,
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('\$${product.price.toString()}'),
                trailing: Icon(
                  Icons.shopping_cart,
                  size: 20,
                ),
                backgroundColor: Colors.black45,
              ),
            ),
          ),
        ),
      ),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        // Navigator.of(context).pushNamed('/meals', arguments: category);
      },
    );
  }
}
