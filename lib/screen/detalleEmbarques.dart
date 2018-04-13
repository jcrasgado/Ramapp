import 'dart:io';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetalleEmbarques extends StatefulWidget {

  DetalleEmbarques();

  @override
  _MyDetalleEmbarquesState createState() => new _MyDetalleEmbarquesState();
}

class _MyDetalleEmbarquesState extends State<DetalleEmbarques>{

  /* Lista de Embarques */
  List embarques;
  var id_cliente = "";
  var id_embarque = "";
  Widget content;

  @override
  void initState() {
    super.initState();
    this.getEmbarques();
  }

  Future<String> getEmbarques() async  {

    _onLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id_cliente  = prefs.getString("id_cliente");
    id_embarque = prefs.getString("id_embarque");

    var httpClient = new HttpClient();
    var uri = new Uri.https(  'zarotransportation.com', '/fletes/wsclientes/detalleEmbarque/'+id_cliente+'/'+id_embarque);

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

    Navigator.pop(context);
    return "success";
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
        title: new Text("Embarque "+id_embarque)
    ),
    body: new ListView(
    children: <Widget>[

      new Container(
        padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: new Text("GENERALES", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
        margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
      ),

      new Container(
        padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(embarques[0]['tipo_embarque']),
          ],
        ),
        margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      ),

    ],
    ),

    );
  }

}