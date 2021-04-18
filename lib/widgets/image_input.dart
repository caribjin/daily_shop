import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final picker = ImagePicker();

  Future<void> _takePicture() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    setState(() {
      if (pickedFile != null) {
        _storedImage = File(pickedFile.path);
      }
    });

    if (_storedImage != null) {
      final appDocumentDir = await syspath.getApplicationDocumentsDirectory();
      final imageName = path.basename(_storedImage!.path);
      _storedImage!.copySync('${appDocumentDir.path}/$imageName');
      print('${appDocumentDir.path}/$imageName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('No Image Taken'),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        TextButton.icon(
          icon: Icon(Icons.camera),
          label: Text('Take Picture'),
          onPressed: _takePicture,
        ),
      ],
    );
  }
}
