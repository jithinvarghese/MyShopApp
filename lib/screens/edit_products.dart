import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductsScreen extends StatefulWidget {
  static const screenName = 'edit-product-screen';

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  // You have to dispose FocusNode after the use ,otherwose it make leak in the libarry
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  // global key
  final _form = GlobalKey<FormState>();
  var _editedProducts =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var _isInit = true;
  var _initvalues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  // to extract the argument value we cant add this in iniState so ,

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');

    if (_isInit) {
   
      final productId = ModalRoute.of(context).settings.arguments as String;
      
      if (productId != null) {
        _editedProducts =
            Provider.of<Products>(context, listen: false).findById(productId);
        // new map registering
        _initvalues = {
          'title': _editedProducts.title,
          'description': _editedProducts.description,
          'price': _editedProducts.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProducts.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    _imageFocusNode.removeListener(_updateImageURL);
    super.dispose();
  }

  void _updateImageURL() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http')) &&
          (!_imageUrlController.text.startsWith('https')) &&
          (!_imageUrlController.text.endsWith('.png')) &&
          (!_imageUrlController.text.endsWith('.jpg'))) {
        return;
      }

      setState(() {});
    }
  }

  void _saveForm() {
    // this will trigger all the validator
    final isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    if (_editedProducts.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProducts.id, _editedProducts);
    } else {
      // listen false i dont make changes in products,just updating the prodcuts
      Provider.of<Products>(context, listen: false).addProduct(_editedProducts);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    print('listner test');
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initvalues['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProducts = Product(
                      title: value,
                      description: _editedProducts.description,
                      price: _editedProducts.price,
                      imageUrl: _editedProducts.imageUrl,
                      id: _editedProducts.id,
                      isFavorite: _editedProducts.isFavorite);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initvalues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProducts = Product(
                      title: _editedProducts.title,
                      description: _editedProducts.description,
                      price: double.parse(value),
                      imageUrl: _editedProducts.imageUrl,
                      id: _editedProducts.id,
                      isFavorite: _editedProducts.isFavorite);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'PLease a number gretaer than 0';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initvalues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedProducts = Product(
                      title: _editedProducts.title,
                      description: value,
                      price: _editedProducts.price,
                      imageUrl: _editedProducts.imageUrl,
                      id: _editedProducts.id,
                      isFavorite: _editedProducts.isFavorite);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value';
                  }
                  if (value.length < 10) {
                    return 'should be grether than 10 letter';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Container(
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter the URL')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      // this reason to use the contoller here beciz we need to show the  value before submitting
                      // usaly in Form() we dont need to use the controller
                      controller: _imageUrlController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      focusNode: _imageFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedProducts = Product(
                            title: _editedProducts.title,
                            description: _editedProducts.description,
                            price: _editedProducts.price,
                            imageUrl: value,
                            id: _editedProducts.id,
                            isFavorite: _editedProducts.isFavorite);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a image URL';
                        }
                        if (!value.startsWith('http') ||
                            !value.startsWith('https')) {
                          return 'please enter a valide URl';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg')) {
                          return 'please enter a valide URl exten';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
