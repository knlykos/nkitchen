import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:mobile/screens/add_card.dart';
import 'package:mobile/widgets/drawer.dart';

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
        body: Container(
          child: Column(
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.card_giftcard),
                      title: Text('4554 4545 5454'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                      enabled: true,
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.card_giftcard),
                      title: Text('4554 4545 5454'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                      enabled: true,
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 5.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.card_giftcard),
                      title: Text('4554 4545 5454'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                      enabled: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Mi Calimax'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: _printFn,
          ),
        ),
        drawer: CxDrawer(),
        key: _scaffoldKey);
  }
}
