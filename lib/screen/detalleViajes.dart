import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:core';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class DetalleViajes extends StatefulWidget {

  DetalleViajes();

  @override
  _MyDetalleViajes createState() => new _MyDetalleViajes();
}

class _MyDetalleViajes extends State<DetalleViajes>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
          title: new Text("Viaje")
      ),
      body: new ListView(
        children: <Widget>[],
      ),

    );
  }

}