import 'package:flutter/material.dart';


class ProductCreate extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _toggleDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('nKitchen'),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: _toggleDrawer,
      ),
    ),body: Text('Hola'),);
  }
}