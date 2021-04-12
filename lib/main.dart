import 'package:daily_shop/pages/auth_page.dart';
import 'package:daily_shop/providers/auth.dart';
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
import 'package:daily_shop/pages/user_product_page.dart';

import 'providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
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
        initialRoute: '/auth',
        routes: {
          '/': (_) => HomePage(),
          '/auth': (_) => AuthPage(),
          '/product': (_) => ProductDetailPage(),
          '/user-products': (_) => UserProductPage(),
          '/edit-product': (_) => EditProductPage(),
          '/cart': (_) => CartPage(),
          '/edit': (_) => EditProductPage(),
          '/orders': (_) => OrdersPage(),
          '/settings': (_) => SettingsPage(),
        },
      ),
    );
  }
}
