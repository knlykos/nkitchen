import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/provider/products.dart';
import 'package:mobile/screens/add_product.dart';
import 'package:mobile/screens/food/food_details.dart';
import 'package:provider/provider.dart';
import 'package:mobile/widgets/drawer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
    final productsProvider = Provider.of<ProductsProvider>(context);
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
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     var id =
        //         Firestore.instance.collection('products').document().documentID;
        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //       return AddProduct(
        //         id: id,
        //         code: '',
        //         description: '',
        //         price: 0,
        //       );
        //     }));
        //   },
        // ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('products')
                    .orderBy('code')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Text('Loading...');
                  return GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this would produce 2 rows.

                    crossAxisCount: 1,
                    childAspectRatio: 1.2,
                    // Generate 100 Widgets that display their index in the List
                    children:
                        List.generate(snapshot.data.documents.length, (index) {
                      return Hero(
                        tag: snapshot.data.documents[index].documentID,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderOnForeground: false,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10.0),
                          // ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          elevation: 3,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: FractionalOffset.topCenter,
                                      image: NetworkImage(snapshot
                                          .data.documents[index].data['image']),
                                    ),
                                  ),
                                  child: Material(
                                      child: InkWell(
                                        splashColor:
                                            Color.fromRGBO(255, 255, 255, 0.15),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                productsProvider.id = snapshot
                                                    .data
                                                    .documents[index]
                                                    .documentID;
                                                productsProvider.description =
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data['description'];
                                                productsProvider.price =
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data['price'];

                                                productsProvider.code = snapshot
                                                    .data
                                                    .documents[index]
                                                    .data['code'];

                                                productsProvider.image =
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data['image'];
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
                                  print('Agregado');
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 250),
                                padding: EdgeInsets.all(5),
                                child: ListTile(
                                  title: Text(snapshot.data.documents[index]
                                      .data['description']),
                                  subtitle: Text(
                                      '\$${snapshot.data.documents[index].data['price'].toString()}'),
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
                },
              ),
            ),
          ],
        ),

        //         child: Stack(
        //   children: <Widget>[
        //     Positioned(
        //       bottom: 0,
        //       right: 0,
        //       child: Text(
        //         snapshot.data.documents[index].data['code'],
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 20,
        //       child: Text(
        //         snapshot
        //             .data.documents[index].data['description'],
        //         style: TextStyle(color: Colors.black87),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 0,
        //       left: 0,
        //       child: Text(
        //         '\$${snapshot.data.documents[index].data['price']}'
        //             .toString(),
        //       ),
        //     ),
        //   ],
        // ),

        // body: StreamBuilder(
        //   stream: Firestore.instance
        //       .collection('products')
        //       .orderBy('code')
        //       .snapshots(),
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) return Text('Loading...');
        //     return ListView.builder(
        //       itemCount: snapshot.data.documents.length,
        //       itemBuilder: (context, index) =>
        //           _buildListItem(context, snapshot.data.documents[index]),
        //     );
        //   },
        // ),

        appBar: AppBar(
          title: Text('Restaurante'),
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
