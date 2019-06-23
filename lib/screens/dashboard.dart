import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nkitchen/models/product_model.dart';
import 'package:nkitchen/provider/products.dart';
import 'package:nkitchen/screens/food/food_details.dart';
import 'package:provider/provider.dart';
import 'package:nkitchen/widgets/drawer.dart';

import 'dart:async';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _printFn() {
    _scaffoldKey.currentState.openDrawer();
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 0),
        width: 110,
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       color: Colors.white,
        //       width: 2.0,
        //       style: BorderStyle.solid,
        //     ),
        //     borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            document.data['name'],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    StreamController<ProductModel> streamController = StreamController();
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: StreamProvider.value(
                value: productsProvider.streamProducts(),
                child: ProductCards(),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text('nKitchen'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/product/add');
              },
            ),
          ],
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: _printFn,
          ),
          bottom: PreferredSize(
            preferredSize: Size.square(40),
            child: Expanded(
              flex: 1,
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('categories')
                    .orderBy('sequence')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Text('Loading...');
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data.documents[index]),
                  );
                },
              ),
            ),
          ),
        ),
        drawer: CxDrawer(),
        key: _scaffoldKey);
  }
}

class ProductCards extends StatefulWidget {
  @override
  _ProductCardsState createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final productsModel = Provider.of<List<ProductModel>>(context);
    if (productsModel.isEmpty) {
      return Text('Loading...');
    } else {
      return GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 1.2,
        children: List.generate(productsModel.length, (index) {
          return Hero(
            tag: productsModel[index].hashCode,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderOnForeground: false,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              elevation: 3,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.topCenter,
                          image: NetworkImage(productsModel[index].image),
                        ),
                      ),
                      child: Material(
                          child: InkWell(
                            splashColor: Color.fromRGBO(255, 255, 255, 0.15),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    productsProvider.productModel =
                                        productsModel[index];
                                    return FoodDetails();
                                  },
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: Container(
                              height: 250,
                            ),
                          ),
                          color: Colors.transparent)),
                  IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            productsModel[index].description + ' agregado',
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 0,
                    child: childPopup(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(productsModel[index].description),
                      subtitle:
                          Text('\$${productsModel[index].price.toString()}'),
                    ),
                  ),
                  // Positioned.fill(
                  //   child: Material(
                  //     color: Colors.transparent,
                  //     child: new InkWell(onTap: () {}),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }),
      );
    }
  }

  Widget childPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Edit",
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "Delete",
                ),
              ),
            ],
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onSelected: (value) {
          switch (value) {
            case 1:
              print('edita');
              break;
            case 2:
              print('elimina');
              break;
          }
        },
      );
}
