import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nkitchen/models/product_model.dart';
import 'package:nkitchen/provider/categories.dart';
import 'package:nkitchen/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:nkitchen/models/category_model.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _longDescriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _categoryController = TextEditingController();
  final rating = TextEditingController();
  String appbarTitle = '';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 1,
              controller: _descriptionController,
              onChanged: (value) {
                setState(() {
                  appbarTitle = _descriptionController.text;
                });
              },
              decoration:
                  InputDecoration(isDense: true, labelText: 'Description'),
            ),
            TextField(
              maxLines: 5,

              controller: _longDescriptionController,
              decoration:
                  InputDecoration(isDense: true, labelText: 'Long Description'),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _codeController,
                    decoration:
                        InputDecoration(isDense: true, labelText: 'Code'),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Flexible(
                  child: TextField(
                    maxLines: 1,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(12),
                      WhitelistingTextInputFormatter.digitsOnly,
                      BlacklistingTextInputFormatter.singleLineFormatter
                    ],
                    controller: _priceController,
                    decoration:
                        InputDecoration(isDense: true, labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            TextField(
              controller: _imageController,
              decoration:
                  InputDecoration(isDense: true, labelText: 'Image URL'),
            ),
            StreamProvider.value(
              value: CategoriesProvider().getStreamCategories(),
              child: CategoriesDropdown(),
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
//                      productModel.code = _codeController.text;
//                      print(productModel.code);
//                      productModel.description =
//                          _descriptionController.text;
//                      productModel.price =
//                          num.parse(_priceController.text);
//                      productModel.image = _imageController.text;
//                      productModel.longDescription= _longDescriptionController.text;
//                      productModel.rating = 5;
//                      productsProvider.productModel = productModel;
                print({'CATEGORY PROVIDER', productsProvider.category});
                productsProvider.productModel = ProductModel(
                    code: _codeController.text,
                    image: _imageController.text,
                    category: productsProvider.category,
                    description: _descriptionController.text,
                    longDescription: _longDescriptionController.text,
                    price: num.parse(_priceController.text),
                    rating: 5);

                productsProvider.addProducts().whenComplete(() {
                  Navigator.of(context).pushNamed('/products');
                });
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(this.appbarTitle  == '' ? 'New Food' : _descriptionController.text),
      ),
    );
  }
}

class CategoriesDropdown extends StatefulWidget {
  CategoriesDropdown({Key key}) : super(key: key);

  @override
  _CategoriesDropdownState createState() => _CategoriesDropdownState();
}

class _CategoriesDropdownState extends State<CategoriesDropdown> {
  String dropdownValue = 'Pastas';

  Widget build(BuildContext context) {
    final categoriesModel = Provider.of<List<CategoryModel>>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    print({'Category', productsProvider.category});
    if (categoriesModel.isNotEmpty) {
      return DropdownButton<String>(
        value: dropdownValue,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            productsProvider.category = dropdownValue;
          });
        },
        items: categoriesModel
            .map<DropdownMenuItem<String>>((CategoryModel value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList(),
      );
    }
  }
}
