import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daily_shop/pages/home_page.dart';
import 'package:daily_shop/pages/product_detail_page.dart';
import 'package:daily_shop/pages/settings_page.dart';
import 'package:daily_shop/pages/cart_page.dart';
import 'package:daily_shop/providers/cart.dart';
import 'package:daily_shop/pages/edit_product_page.dart';
import 'package:daily_shop/pages/orders_page.dart';
import 'package:daily_shop/providers/orders.dart';

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
        ChangeNotifierProvider<Orders>(create: (_) => Orders()),
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
          '/': (_) => HomePage(),
          '/product': (_) => ProductDetailPage(),
          '/cart': (_) => CartPage(),
          '/edit': (_) => EditProductPage(),
          '/orders': (_) => OrdersPage(),
          '/settings': (_) => SettingsPage(),
        },
      ),
    );
  }
}
