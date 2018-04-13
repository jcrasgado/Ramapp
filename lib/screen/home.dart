import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  Home(this.username, this.email);

  final String username;
  final String email;

  @override
  _MyHomeState createState() => new _MyHomeState(username, email);
}

class _MyHomeState extends State<Home> {

  _MyHomeState(this.username, this.email);

  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:
        new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image.asset( 'assets/images/ram_icon.png', width: 150.0, height: 150.0, ),
              new Text( username, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
              new Text( email, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child:new Text( "0", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), ) ),

                            new Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child:new Text( "Embarques", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), ) ),

                            new Icon( Icons.track_changes, size: 36.0)
                          ]

                      ),

                      new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child:new Text( "0", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), ) ),

                            new Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child:new Text( "En Ruta", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), ) ),

                            new Icon( Icons.traffic, size: 36.0)
                          ]

                      ),

                      new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child:new Text( "0", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), ) ),

                            new Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child:new Text( "Terminados", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), ) ),

                            new Icon( Icons.widgets, size: 36.0)
                          ]

                      ),

                  ]

              )
            ]

        ),
    );
  }

}