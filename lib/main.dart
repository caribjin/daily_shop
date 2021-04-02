import 'package:flutter/material.dart';

import 'pages/category_meals_page.dart';
import 'pages/home_page.dart';
import 'pages/meal_detail_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Shop',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/meals': (context) => CategoryMealsPage(),
        '/meal': (context) => MealDetailPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
