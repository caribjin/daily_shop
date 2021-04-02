import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailPage extends StatelessWidget {
  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      width: double.infinity,
      color: Colors.black12,
      // alignment: Alignment.centerRight,
      padding: EdgeInsets.all(10),
    );
  }

  Widget buildList(BuildContext context, List<String> elements) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 12,
      ),
      child: Column(
        children: elements.map((element) {
          return Container(
            width: double.infinity,
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(element),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                meal.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildList(context, meal.ingredients ?? []),
            buildSectionTitle(context, 'Steps'),
            buildList(context, meal.steps ?? []),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(meal.id);
        },
      ),
    );
  }
}
