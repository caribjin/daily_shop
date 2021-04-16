import 'package:flutter/material.dart';

class AddPlacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Place')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              TextField(),
              TextField(),
              TextField(),
              TextField(),
            ],
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }
}
