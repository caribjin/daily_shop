import 'package:daily_shop/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final location = Location();
    final LocationData? locData = await location.getLocation();

    if (locData == null) return;

    final previewUrl = LocationHelper.generateLocationPreviewImage(latitude: locData.latitude!, longitude: locData.longitude!);

    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  @override
  void initState() {
    _getCurrentUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.5,
            ),
          ),
          child: _previewImageUrl == null
              ? CircularProgressIndicator()
              : Image.network(
                  _previewImageUrl ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              onPressed: () {
                _getCurrentUserLocation();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              onPressed: () {},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }
}
