import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  Home(this.username, this.email);

  final String username;
  final String email;

  @override
  _MyHomeState createState() => new _MyHomeState(username);
}

class _MyHomeState extends State<Home> {

  _MyHomeState(this.username);

  final String username;

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