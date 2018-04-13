import 'dart:io';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class Embarques extends StatefulWidget {

  Embarques();

  @override
  _MyEmbarquesState createState() => new _MyEmbarquesState();
}

class _MyEmbarquesState extends State<Embarques> {

  _MyEmbarquesState();

  /* Lista de Embarques */
  List embarques;
  var id_cliente = "";
  Widget content;

  @override
  void initState() {
    super.initState();
    this.getEmbarques();
  }

  /* Main Acceso */
  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new CircularProgressIndicator(),
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                      child: new Text("Cargando..."),
                    ),
                  ])
              ,),
          ],
        ),
      ),
    );
    new Future.delayed(new Duration(seconds: 3),);
  }

  Future<String> getEmbarques() async  {

      _onLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id_cliente = prefs.getString("id_cliente");

      var httpClient = new HttpClient();
      var uri = new Uri.https(  'zarotransportation.com', '/fletes/wsclientes/listaEmbarques/'+id_cliente );

      print(uri.toString());
      var request = await httpClient.getUrl(uri);
      var response = await request.close();

      if (response.statusCode == HttpStatus.OK) 
      {
        var dataJson = await response.transform(utf8.decoder).join();
        this.setState((){
          embarques = json.decode(dataJson);
        });
      }

      print(embarques);

      if(embarques.length > 0)
      {
        content = new ListView.builder(
            itemCount: embarques.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                child: new GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    prefs.setString('id_embarque', embarques[index]['idEmbarque']);
                    Navigator.of(context).pushNamed('/DetalleEmbarques');
                  },
                  child:new Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: new Row(
                      children: <Widget>[

                        new Container(
                          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                          child: new Column(
                            children: <Widget>[
                              new Image.asset("assets/images/truck.png", width: 70.0,),
                              new Text("Proceso", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, height: 1.5),),
                            ],
                          ),
                        ),

                        new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text("E" + embarques[index]['idEmbarque'], style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                              new Text("Destino:", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, height: 2.0),),
                              new Text(embarques[index]['ciudad_para'] + ', ' + embarques[index]['estado_llegada'], style: new TextStyle(fontSize: 15.0),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      }
      else
      {
        content = new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.track_changes, color: Colors.black26,),
                  new Text("Sin Embarques", style: new TextStyle(fontSize: 28.0, color: Colors.black26),)
                ],
              ),
        ]);
      }

      /*
      * new ListTile(
                  leading: new Image.asset("assets/images/truck.png"),
                  title: new Text("Destino"),
                  subtitle: new Text(embarques[index]['ciudad_para']+' - '+embarques[index]['estado_llegada'], style: new TextStyle(fontSize: 15.0),),
                ),


                new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                        child: new Column(
                          children: <Widget>[
                            new Image.asset("assets/images/truck.png", width: 70.0,),
                            new Text("Proceso", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, height: 1.5),),
                          ],
                        ),
                      ),

                      new Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text("ID Embarque " + embarques[index]['idEmbarque'], style: new TextStyle(fontSize: 18.0),),
                            new Text("Destino:", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, height: 2.0),),
                            new Text(embarques[index]['ciudad_para'] + ', ' + embarques[index]['estado_llegada'], style: new TextStyle(fontSize: 15.0),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      * */

      Navigator.pop(context);
      return "success";
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: content,
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: Colors.red,
          onPressed: (){
            Navigator.of(context).pushNamed('/CreateEmbarques');
          }
      )
    );
  }

}



