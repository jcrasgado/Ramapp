import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:core';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class CreateEmbarques extends StatefulWidget {

  CreateEmbarques();

  @override
  _MyCreateEmbarquesState createState() => new _MyCreateEmbarquesState();
}

class _MyCreateEmbarquesState extends State<CreateEmbarques> {

  _MyCreateEmbarquesState();

  Oficinas selectOfina;
  List<Oficinas> oficinas = <Oficinas>[const Oficinas(1, "Oficina 1"), const Oficinas(2, "Oficina 2")];

  Grupos selectGrupo;
  List<Grupos> grupos = <Grupos>[const Grupos(1, "Grupo 1"), const Grupos(2, "Grupo 2")];


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  var _dateTime = new DateTime.now();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        appBar: new AppBar(
            title: new Text("Crear Embarques")
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
                  new DropdownButton<Oficinas>(
                    hint: new Text("OFICINA"),
                    value: selectOfina,
                    onChanged: (Oficinas newValue) {
                      setState(() {
                        selectOfina = newValue;
                      });
                    },
                    items: oficinas.map((Oficinas oficina ) {
                      return new DropdownMenuItem<Oficinas>(
                        value: oficina,
                        child: new Text( oficina.oficina, style: new TextStyle(color: Colors.black) ),

                      );
                    }).toList(),
                  ),
                ],
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new DropdownButton<Grupos>(
                    hint: new Text("GRUPO"),
                    value: selectGrupo,
                    onChanged: (Grupos newValue) {
                      setState(() {
                        selectGrupo = newValue;
                      });
                    },
                    items: grupos.map((Grupos grupo ) {
                      return new DropdownMenuItem<Grupos>(
                        value: grupo,
                        child: new Text(
                          grupo.grupo,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            /* ORIGEN DEL EMBARQUE */
            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Text("ORIGEN", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
            ),


            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new TextField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'CÓDIGO POSTAL',
                ),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new TextField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'ORIGEN EMBARQUE',
                ),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            /* DESTINO DEL EMBARQUE */
            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Text("DESTINO", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new TextField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'CÓDIGO POSTAL',
                ),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new TextField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'DESTINO EMBARQUE',
                ),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            /* COSTOS */
            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Text("COSTOS", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  hintText: 'TARIFA',
                ),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new FocusScope(
                node: new FocusScopeNode(),
                child: new TextFormField(
                    style: new TextStyle(color: Colors.black26),
                    decoration:
                    new InputDecoration(
                      hintText: 'MILLAS GOOGLE',
                    ),
                  ),
                ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new TextField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'RPM',
                ),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),


            /* FECHAS */
            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Text("FECHA DE SALIDA", style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
              margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new ListTile(
                leading: new Icon(Icons.today, color: Colors.grey[500]),
                title: new DateTimeItem(
                  dateTime: _dateTime,
                  onChanged: (dateTime) => setState(() => _dateTime = dateTime),
                ),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            /* FECHAS */
            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Text("FECHA DE ENTREGA", style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
              margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new ListTile(
                leading: new Icon(Icons.today, color: Colors.grey[500]),
                title: new DateTimeItem(
                  dateTime: _dateTime,
                  onChanged: (dateTime) => setState(() => _dateTime = dateTime),
                ),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            /* COMFIRMACION */
            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Text("CONFIRMACIÓN", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new ListTile(
                leading: new Icon(Icons.file_upload, color: Colors.grey[500]),
                title: new Text(_localPath.toString()),
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),

            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new RaisedButton(
                child: new Text('GUARDAR'),
                color: Colors.red,
                textColor: Colors.white,
                textTheme: ButtonTextTheme.accent,
                onPressed: () {
                },
              ),
              margin: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
            ),


          ],
        ),

    );
  }

}

class Oficinas{

  const Oficinas(this.id, this.oficina);

  final int id;
  final String oficina;
}

class Grupos{

  const Grupos(this.id, this.grupo);

  final int id;
  final String grupo;
}


class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = dateTime == null
            ? new DateTime.now()
            : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 2.0),
                child: new Text(new DateFormat('EEE, MMM d yyyy').format(date))),
          ),
        ),
        /*new InkWell(
          onTap: (() => _showTimePicker(context)),
          child: new Padding(
              padding: new EdgeInsets.symmetric(vertical: 8.0),
              child: new Text('$time')),
        ), */
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(const Duration(days: 20000)),
        lastDate: date.add(const Duration(days: 20000) )); //new DateTime.now());

    if (dateTimePicked != null) {
      onChanged(new DateTime(dateTimePicked.year, dateTimePicked.month,
          dateTimePicked.day, time.hour, time.minute));
    }
  }

  Future _showTimePicker(BuildContext context) async {
    TimeOfDay timeOfDay =
    await showTimePicker(context: context, initialTime: time);

    if (timeOfDay != null) {
      onChanged(new DateTime(
          date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute));
    }
  }
}
