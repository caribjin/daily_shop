import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListMenu(String text, IconData icon, Function handlerTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: () => handlerTap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListMenu('Meals', Icons.restaurant, () => Navigator.of(context).pushReplacementNamed('/')),
          buildListMenu('Settings', Icons.settings, () => Navigator.of(context).pushReplacementNamed('/settings')),
        ],
      ),
    );
  }
}
