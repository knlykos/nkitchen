import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './../models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class Public extends StatefulWidget {
  @override
  _PublicState createState() => _PublicState();
}

class _PublicState extends State<Public> {
  final lusernameController = TextEditingController();
  final lpasswordController = TextEditingController();
  final susernameController = TextEditingController();
  final spasswordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool hasUser = false;
  // Controla la manera en que se va a user el widget, si alguno usuario ya inicio sesion anteriormente
  // Guarda el estado en alguna base de datos o en disco.
  void _login() {
    Future<List<Usuario>> fetchPost() async {
      final response = await http.post('https://calimaxjs.com/usuario',
          body: json.encode({
            'param_in': {
              'action': 'LG',
              'email': this.lusernameController.text,
              'password': this.lpasswordController.text
            },
            'param_out': {'gettoken': ''},
            'funcion': 'sp_usuario'
          }),
          headers: {'Content-type': 'application/json'});
      var responseJson = (json.decode(response.body) as List)
          .map((e) => Usuario.fromJson(e))
          .toList();

      storage.write(key: 'token', value: responseJson[0].token);
      if (responseJson[0].codigo == 0) {
        Navigator.pushNamed(context, '/dashboard');
      } else {
        final snackBar = SnackBar(content: Text(responseJson[0].mensaje));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
      return responseJson;
    }

    fetchPost();
  }

  void _hasUser() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      hasUser = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image.asset('assets/images/nkodex-logo.png'),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.indigo,
            tabs: <Widget>[
              Tab(
                text: 'Iniciar Sesión',
              ),
              Tab(
                text: 'Registro',
              )
            ],
          ),
        ),
        // https://flutter.dev/docs/development/ui/layout
        body: TabBarView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: TextFormField(
                      controller: lusernameController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(hintText: 'Correo Electrónico'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: TextFormField(
                      controller: lpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Contraseña'),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: FlatButton(
                            color: Colors.indigo,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            onPressed: _login,
                            child: Text('Iniciar Sesión'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text('Olvidé mi Contraseña'),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Divider(),
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Container(
                  //         child: FlatButton(
                  //           color: Colors.indigo,
                  //           textColor: Colors.white,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(7),
                  //           ),
                  //           onPressed: () {
                  //             print('Login with face ID');
                  //           },
                  //           child: Text('Login with face ID'),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(FontAwesomeIcons.facebookF),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(FontAwesomeIcons.twitter),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(FontAwesomeIcons.google),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: TextFormField(
                      controller: susernameController,
                      obscureText: false,
                      decoration: InputDecoration(hintText: 'Usuario'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: TextFormField(
                      controller: spasswordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Contraseña'),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: FlatButton(
                            color: Colors.indigo,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            onPressed: () {
                              print(susernameController.text);
                              print(spasswordController.text);
                            },
                            child: Text('Registrarse'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  //   child: Text('Forgot password'),
                  // ),
                  Expanded(
                    child: Row(
                      children: <Widget>[],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Divider(),
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Container(
                  //         child: FlatButton(
                  //           color: Colors.indigo,
                  //           textColor: Colors.white,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(7),
                  //           ),
                  //           onPressed: () {
                  //             print('Login with face ID');
                  //           },
                  //           child: Text('Login with face ID'),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(FontAwesomeIcons.facebookF),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(FontAwesomeIcons.twitter),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(FontAwesomeIcons.google),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hasUserSection = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Hello again,',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left),
          Text(
            'Quinnbriar',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, height: 1.5),
          ),
          Text(
            "This isn't me",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 2,
                color: Colors.indigo),
          ),
        ],
      ),
      Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://randomuser.me/api/portraits/men/33.jpg'))),
      )
    ],
  );

  Widget inputUserSection = Container(
    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
    child: TextFormField(
      obscureText: true,
      decoration: InputDecoration(hintText: 'Password'),
    ),
  );
}
