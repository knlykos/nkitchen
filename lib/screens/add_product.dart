import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nkitchen/provider/products.dart';

class AddProduct extends StatefulWidget {
  AddProduct({this.id, this.code, this.description, this.price});
  final String id;
  final String code;
  final String description;
  final num price;

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productsProvider = ProductsProvider();
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
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(12),
                            WhitelistingTextInputFormatter.digitsOnly,
                            BlacklistingTextInputFormatter.singleLineFormatter
                          ],
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
                      productsProvider
                          .addProducts(
                              code: _codeController.text,
                              description: _descriptionController.text,
                              price: num.parse(_priceController.text))
                          .whenComplete(() {
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
