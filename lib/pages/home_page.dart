import 'package:daily_shop/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import 'products_overview_page.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Shop'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductsOverviewPage(),
          FavoritesPage(),
        ],
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.category),
              text: 'Products',
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: 'Favorites',
            )
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
        ),
      ),
    );
  }
}
