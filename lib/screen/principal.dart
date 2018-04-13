import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:RamApp/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:RamApp/screen/embarques.dart';
import 'package:RamApp/screen/viajes.dart';

class Principal extends StatefulWidget {
	
	final String title = 'Ram App';
	@override
	_MyPrincipalState createState() => new _MyPrincipalState(title: title);
}

class _MyPrincipalState extends State<Principal> {

	_MyPrincipalState({
		Key key,
		this.title,
	});

	final String title;

	String username = '';
	String nombre = '';
	String email = '';
	String titulo = '';
	Widget contenido;
	int _currentIndex = 0;
	var bgH = Colors.black26;
  var bgE = Colors.black26;
  var bgV = Colors.black26;
	var bgT = Colors.black26;

	getSharedPreferences() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();

		setState(() {
			username = prefs.getString("username");
			nombre = prefs.getString("nombre");
			email = prefs.getString("email");

      contenido= new Home(nombre, email);
      bgH = Colors.red;
		});
	}

	_setView (int value)
  {
    switch(value)
    {
      case 0:
        contenido = new Home(username, email);
        titulo = "Home";
        bgH = Colors.red;
        bgE = Colors.black26;
        bgV = Colors.black26;
				bgT = Colors.black26;
        _currentIndex = 0;
        break;

      case 1:
        contenido = new Embarques();
        titulo = "Embarques";
        bgH = Colors.black26;
        bgE = Colors.red;
        bgV = Colors.black26;
				bgT = Colors.black26;
        _currentIndex = 1;
        break;

      case 2:
        contenido = new Viajes();
        titulo = "Viajes";
        bgH = Colors.black26;
        bgE = Colors.black26;
        bgV = Colors.red;
				bgT = Colors.black26;
        _currentIndex = 2;
        break;

			case 3:
				contenido = new Viajes();
				titulo = "Viajes Terminados";
				bgH = Colors.black26;
				bgE = Colors.black26;
				bgV = Colors.black26;
				bgT = Colors.red;
				_currentIndex = 3;
				break;
    }
  }


	@override
	void initState() {
		super.initState();
		getSharedPreferences();
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
				appBar: new AppBar(
					title: new Text(titulo != '' ? titulo : title)
				),
				bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _currentIndex,
					onTap: (value) {
            setState((){
                _setView(value);
            });
					},
					items: <BottomNavigationBarItem>[
						new BottomNavigationBarItem(icon: new Icon(Icons.home), title: new Text("Home"), backgroundColor: bgH ),
						new BottomNavigationBarItem(icon: new Icon(Icons.track_changes), title: new Text("Embarques"), backgroundColor: bgE),
						new BottomNavigationBarItem(icon: new Icon(Icons.traffic), title: new Text("Viajes"), backgroundColor: bgV),
						new BottomNavigationBarItem(icon: new Icon(Icons.widgets), title: new Text("Terminados"), backgroundColor: bgT),
					],
				),
				body: contenido ,
		);
	}
}

