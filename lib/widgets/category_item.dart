import 'package:flutter/material.dart';

import '../pages/category_meals_page.dart';
import '../models/products.dart';

class CategoryItem extends StatelessWidget {
  // late final Category category;

  CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.2,
          ),
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              // category.color.withOpacity(0),
              // category.color.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            // category.title,
            '',
            style: Theme.of(context).textTheme.headline6?.copyWith(
              // color: Colors.white,
              shadows: [
                Shadow(
                  // color: Color.fromRGBO(0, 0, 0, 0.8),
                  color: Colors.white,
                  blurRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.of(context).pushNamed('/meals', arguments: category);
      },
    );
  }
}
