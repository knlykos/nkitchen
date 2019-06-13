import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkitchen/provider/products.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatelessWidget {
  final String code;
  final String description;
  final double price;

  EditProduct({this.code, this.description, this.price});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final _codeController = TextEditingController(text: productsProvider.code);
    final _descriptionController =
        TextEditingController(text: productsProvider.description);
    final _priceController =
        TextEditingController(text: productsProvider.price.toString());
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
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        isDense: true, labelText: 'Description'),
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
                          controller: _priceController,
                          decoration: InputDecoration(
                              isDense: true, labelText: 'Price'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Text('Registrar'),
                    onPressed: () {
                      productsProvider.code = _codeController.text;
                      productsProvider.description =
                          _descriptionController.text;
                      productsProvider.price =
                          double.parse(_priceController.text);

                      // code: _codeController.text,
                      // description: _descriptionController.text,
                      // this.productsProvide.price: _priceController.text
                      productsProvider.updateProduct().whenComplete(() {
                        Navigator.of(context).pushNamed('/products');

                      });
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
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.edit),
              ),
              Tab(
                icon: Icon(Icons.edit_attributes),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class _EditProduct extends State<AddProduct> {

// }
