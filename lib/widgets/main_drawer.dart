import 'package:daily_shop/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            color: Theme.of(context).primaryColor,
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
          buildListMenu('Products', Icons.shop, () => Navigator.of(context).pushNamed('/')),
          buildListMenu('Orders', Icons.payment, () => Navigator.of(context).pushNamed('/orders')),
          Divider(),
          buildListMenu('Manage Products', Icons.edit_rounded, () => Navigator.of(context).pushNamed('/user-products')),
          buildListMenu('Logout', Icons.logout, () => Provider.of<Auth>(context, listen: false).logOut()),
        ],
      ),
    );
  }
}
