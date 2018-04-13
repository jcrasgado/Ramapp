import 'package:flutter/material.dart';
import 'package:RamApp/screen/login.dart';
import 'package:RamApp/screen/principal.dart';
import 'package:RamApp/screen/embarques.dart';
import 'package:RamApp/screen/viajes.dart';
import 'package:RamApp/screen/createEmbarques.dart';
import 'package:RamApp/screen/detalleEmbarques.dart';
import 'package:RamApp/screen/detalleViajes.dart';

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
        '/Embarques': (BuildContext context) => new Embarques(),
        '/Viajes': (BuildContext context) => new Viajes(),
        '/CreateEmbarques': (BuildContext context) => new CreateEmbarques(),
        '/DetalleEmbarques': (BuildContext context) => new DetalleEmbarques(),
        '/DetalleViajes': (BuildContext context) => new DetalleViajes(),
      },
      home: new LoginPage(title: 'ACCESO', onSubmit: null,),
    );
  }

}
