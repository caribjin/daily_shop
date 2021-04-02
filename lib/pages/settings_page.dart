import 'package:daily_shop/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      drawer: MainDrawer(),
      body: Container(
        child: Center(
          child: Text(
            'Settings Page',
          ),
        ),
      ),
    );
  }
}
