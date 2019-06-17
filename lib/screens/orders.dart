import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nkitchen/widgets/drawer.dart';

class OrdersScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void openDrawerFn() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CxDrawer(),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('nKitchen'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: openDrawerFn,
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('orders').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          },
        ),
      ),
    );
  }

/* TODO: Estados   */
// Id de estados
// 0 Cerrado
// 1 Abierto
// 2 Completado
// 3 Pagado
// 4 Issue
// 5
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document.data['table'].toString()),
      subtitle: Text(document.data['orderDate'].toString()),
      onTap: () {
        print(document.documentID);
      },
    );
  }
}
