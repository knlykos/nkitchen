import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:mobile/models/sp_js_100.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/screens/add_card.dart';
import 'package:mobile/widgets/app_bar.dart';
import 'package:mobile/widgets/drawer.dart';

final storage = new FlutterSecureStorage();

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State {
  List<Spjs100> data;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  void _printFn() async {}

  Future<List<Spjs100>> _fetchCards() async {
    final token = await storage.read(key: 'token');
    final response = await http.post('https://calimaxjs.com/tarjetas',
        body: json.encode({
          "param_in": {'action': 'SL'},
          'param_out': {},
          'funcion': 'sp_js_100'
        }),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    var responseJson = (json.decode(response.body) as List)
        .map((e) => Spjs100.fromJson(e))
        .toList();

    return responseJson;
  }

  List<Widget> _listaItems(List<Spjs100> data) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      print(opt.descTarjeta);
      print(opt.sdoMonedero);
      final widgetTemp = ListTile(
        title: Text(opt.cuentaR),
        subtitle: opt.descTarjeta != 'Tarjeta de Monedero'
            ? Text('\$' + opt.sdoVales.toString())
            : Text('\$' + opt.sdoMonedero.toString()),
        leading: Icon(Icons.credit_card),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {},
      );
      opciones..add(widgetTemp)..add(Divider());
    });
    return opciones;
  }

  Widget _list() {
    return FutureBuilder(
      future: _fetchCards(),
      initialData: this.data,
      builder: (BuildContext context, AsyncSnapshot<List<Spjs100>> snapshop) {
        if (snapshop.connectionState == ConnectionState.done) {
          return ListView(
            children: _listaItems(snapshop.data),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('HEY');
          },
        ),
        body: _list(),
        appBar: AppBarWidget(
          title: 'Mi Calimax',
          scaffoldKey: _scaffoldKey,
        ),
        drawer: CxDrawer(),
        key: _scaffoldKey);
  }
}

// class CardsBuilder extends StatelessWidget {
//   final List<Spjs100> cards;

//   CardsBuilder({Key key, this.cards}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: cards.length,
//       itemBuilder: (context, index) {
//         return Column(
//           children: <Widget>[
//             Container(
//               child: Text(),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
