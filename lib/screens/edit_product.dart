import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nkitchen/provider/categories.dart';
import 'package:nkitchen/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:nkitchen/models/category_model.dart';
import 'package:nkitchen/models/product_model.dart';

class EditProduct extends StatefulWidget {
  final ProductModel product;

  EditProduct({Key key, this.product}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController codeController;
  TextEditingController descriptionController;
  TextEditingController longDescriptionController;
  TextEditingController priceController;
  TextEditingController imageController;
  TextEditingController categoryController;
  TextEditingController rating;
  String appbarTitle = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    setState(() {
      codeController = TextEditingController(text: widget.product.code);
      descriptionController =
          TextEditingController(text: widget.product.description);
      longDescriptionController =
          TextEditingController(text: widget.product.longDescription);
      priceController =
          TextEditingController(text: widget.product.price.toString());
      imageController = TextEditingController(text: widget.product.image);
      categoryController = TextEditingController(text: widget.product.category);
    });

//    setState(() {
//      descriptionController.valu
//    });

//    descriptionController.text = productsProvider.productModel.description;
//    codeController.text = widget.product.code;
//    descriptionController.text = widget.product.description;
//    longDescriptionController.text = widget.product.longDescription;
//    priceController.text = widget.product.price.toString();
//    imageController.text = widget.product.image;
//    categoryController.text = widget.product.category;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    maxLines: 1,
                    controller: descriptionController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        isDense: true, labelText: 'Description'),
                  ),
                  TextField(
                    maxLines: 5,
                    controller: longDescriptionController,
                    decoration: InputDecoration(
                        isDense: true, labelText: 'Long Description'),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: codeController,
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
                          controller: priceController,
                          decoration: InputDecoration(
                              isDense: true, labelText: 'Price'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: imageController,
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
                      {
                        productsProvider.productModel = ProductModel(
                            id: widget.product.id,
                            code: codeController.text,
                            image: imageController.text,
                            category: productsProvider.category,
                            description: descriptionController.text,
                            longDescription: longDescriptionController.text,
                            price: num.parse(priceController.text),
                            rating: 5);
                        productsProvider.updateProduct().whenComplete(() {
                          Navigator.of(context).pushNamed('/products');
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Hola'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Hola'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        appBar: AppBar(
          title: Text('Nuevo Producto'),
        ),
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

// class _EditProduct extends State<AddProduct> {

// }
