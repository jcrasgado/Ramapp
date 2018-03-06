import 'package:flutter/material.dart';
import 'login.dart';
import 'package:RamApp/screen/principal.dart';
import 'package:RamApp/screen/embarques.dart';

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
        '/Principal' : (BuildContext context) => new Principal(),
        '/Embarques' : (BuildContext context) => new Embarques(),
      },
      home: new LoginPage(title: 'ACCESO', onSubmit: null,),
    );
  }

}
