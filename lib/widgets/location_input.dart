import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text('No location chosen', textAlign: TextAlign.center)
              : Image.network(
                  _previewImageUrl ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
      ],
    );
  }
}
