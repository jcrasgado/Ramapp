import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

class Embarques extends StatefulWidget {

  Embarques(this.username, this.email);

  final String username;
  final String email;

  @override
  _MyembarquesState createState() => new _MyembarquesState(username);
}

class _MyembarquesState extends State<Embarques> {

  _MyembarquesState(this.username);

  final String username;

  _obtener_embarques() async {

    var httpClient = new HttpClient();
    var uri = new Uri.https( 'zarotransportation.com', 'fletes/wsclientes/listaEmbarques', {'': username });

    print(uri.toString());
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(UTF8.decoder).join();
      var data = JSON.decode(json);

      //return data;
    }

  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);

    _obtener_embarques();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Text(username, style:  new TextStyle(fontSize: 20.0),),
              ),
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Column(children: <Widget>[
                      new Container(child: new Column(
                        children: <Widget>[
                          new Container( child: new Icon(Icons.track_changes, color: Colors.black),),
                          new Container( child: new Text('Embarques'),),
                        ],
                      )),
                      new Container(child: new Text('0', style:  new TextStyle(fontSize: 15.0), ),)
                    ],),
                    new Column(children: <Widget>[
                      new Container(child: new Column(
                        children: <Widget>[
                          new Container( child: new Icon(Icons.traffic, color: Colors.black),),
                          new Container( child: new Text('Viajes'),),
                        ],
                      )),
                      new Container(child: new Text('0', style:  new TextStyle(fontSize: 15.0), ),)
                    ],),
                    new Column(children: <Widget>[
                      new Container(child: new Column(
                        children: <Widget>[
                          new Container( child: new Icon(Icons.monetization_on, color: Colors.black),),
                          new Container( child: new Text('Facturas'),),
                        ],
                      )),
                      new Container(child: new Text('0', style:  new TextStyle(fontSize: 15.0), ),)
                    ],),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

}

