import 'package:daily_shop/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'pages/category_meals_page.dart';
import 'pages/home_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/settings_page.dart';

import 'providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (_) => Products()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Daily Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/product': (context) => ProductDetailPage(),
          '/settings': (context) => SettingsPage(),
        },
      ),
    );
  }
}
