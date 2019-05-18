import 'package:flutter/material.dart';
import 'package:mobile/screens/add_card.dart';

class CxDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Nefi Lopez'),
            accountEmail: Text('nlopezg87@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                "NL",
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            // trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddCard();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Tarjetas'),
            // trailing: Icon(Icons.chevron_right),
            onTap: () {
              print('Tarjetas');
            },
          ),
        ],
      ),
    );
  }
}
