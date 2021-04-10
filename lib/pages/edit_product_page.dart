import 'package:daily_shop/providers/product.dart';
import 'package:daily_shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  String _id = '';

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editingProduct = Product(id: '', title: '', price: 0.0, description: '', imageUrl: '');

  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_handleUpdateImageUrl);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var argId = ModalRoute.of(context)?.settings.arguments;

      if (argId != null) {
        _id = argId as String;
        _editingProduct = Provider.of<Products>(context, listen: false).findById(_id);
        _imageUrlController.text = _editingProduct.imageUrl; // imageUrl은 controller가 지정되어 있으므로, 값을 직접 넣어준다.
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_handleUpdateImageUrl);

    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  void _handleUpdateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _handleSaveForm(BuildContext context) {
    bool validated = _form.currentState!.validate();

    if (!validated) return;

    _form.currentState!.save();

    final productsData = Provider.of<Products>(context, listen: false);

    if (_id == '') {
      productsData.addItem(_editingProduct);
    } else {
      productsData.updateItem(_id, _editingProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          TextButton(
            child: Text('SAVE'),
            onPressed: () => _handleSaveForm(context),
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
                  initialValue: _editingProduct.title,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _editingProduct.title = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _editingProduct.price.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _editingProduct.price = double.parse(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price.';
                    } else if (double.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    } else if (double.parse(value) <= 0) {
                      return 'Please enter a number greater than zero.';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _editingProduct.description,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _editingProduct.description = value!;
                  },
                  maxLength: 100,
                  validator: (value) {
                    if (value == null) return null;

                    if (value.isNotEmpty && value.length > 100) {
                      return 'The description can\'t exceed 100 characters.';
                    }

                    return null;
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
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a url')
                          : Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                              errorBuilder: (_, object, stackTrace) {
                                return Text('Error');
                              },
                            ),
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
                          _handleSaveForm(context);
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (value) {
                          _editingProduct.imageUrl = value!;
                        },
                        maxLength: 100,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a image url';
                          } else if (!value.startsWith('http://') && !value.startsWith('https://')) {
                            return 'Please enter a valid url';
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
