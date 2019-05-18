import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _printFn() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mi Calimax'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: _printFn,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Nefi Lopez'),
                accountEmail: Text('nlopezg87@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "NL",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
              ListTile(
                title: Text('Inicio'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text('Tarjetas'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        key: _scaffoldKey);
  }
}
