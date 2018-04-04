import 'package:flutter/material.dart';
import 'package:RamApp/screen/login.dart';
import 'package:RamApp/screen/principal.dart';

void main() => runApp(new RamApp());

class RamApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'RAM',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => new LoginPage(onSubmit: null),
        '/Principal': (BuildContext context) => new Principal(),
      },
      home: new LoginPage(title: 'ACCESO', onSubmit: null,),
    );
  }

}
