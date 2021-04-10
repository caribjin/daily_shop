import 'package:daily_shop/providers/product.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _titleFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _newProduct = Product(
    id: '',
    title: '',
    price: 0.0,
    description: '',
    imageUrl: '',
    isFavorite: false
  );

  @override
  void initState() {
    super.initState();

    _imageUrlFocusNode.addListener(_handleUpdateImageUrl);
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    _imageUrlFocusNode.removeListener(_handleUpdateImageUrl);

    super.dispose();
  }

  void _handleUpdateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _handleSaveForm() {
    bool validated = _form.currentState!.validate();

    if (!validated) return;

    _form.currentState!.save();

    print(_newProduct.title);
    print(_newProduct.price);
    print(_newProduct.description);
    print(_newProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          TextButton(
            child: Text('SAVE'),
            onPressed: _handleSaveForm,
            style: TextButton.styleFrom(primary: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: _titleFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _newProduct.title = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_titleFocusNode);
                  },
                  onSaved: (value) {
                    if (value == null || value.isEmpty) return;

                    _newProduct.price = double.parse(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  focusNode: _descriptionFocusNode,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _newProduct.description = value!;
                  },
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty ? Text('Enter a url') : Image.network(_imageUrlController.text, fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        decoration: const InputDecoration(
                          labelText: 'Image URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _handleSaveForm();
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (value) {
                          _newProduct.imageUrl = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a image url';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
