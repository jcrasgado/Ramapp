import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

	getSharedPreferences() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();

		setState(() {
			username = prefs.getString("_username");
		});
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
					title: new Text(title),
				),
				drawer: new Drawer(
						child: new ListView(
							children: <Widget>[
								new UserAccountsDrawerHeader(
									currentAccountPicture: new CircleAvatar(
										backgroundColor: Colors.red.shade200,
										child: new Icon(Icons.person),
									),
									accountName: new Text(username),
									accountEmail: new Text(username + '@example.com'),
									otherAccountsPictures: <Widget>[
										new GestureDetector(
											onTap: () {},
											child: new Semantics(
												label: 'Ram',
												child: const CircleAvatar(
													backgroundImage: const AssetImage(
															"assets/images/icon.png"),
												),
											),
										),
									],
									margin: EdgeInsets.zero,
								),
								new ListTile(
									leading: new CircleAvatar(child: new Icon(
										Icons.track_changes, color: Colors.white,)),
									title: new Text('Embarques'),
									onTap: () { Navigator.of(context).pushNamed('/Embarques'); },
								),
								new ListTile(
									leading: new CircleAvatar(
											child: new Icon(Icons.traffic, color: Colors.white,)),
									title: new Text('Viajes'),
									onTap: () {},
								),
								new ListTile(
									leading: new CircleAvatar(child: new Icon(
										Icons.monetization_on, color: Colors.white,)),
									title: new Text('Facturas'),
									onTap: () {},
								),
								new Divider(),
								new ListTile(
									leading: new CircleAvatar(
											child: new Icon(Icons.close, color: Colors.white,)),
									title: new Text('Cerrar Sessión'),
									onTap: () {},
								),
							],
						)
				),
				body: new Container(
					padding: new EdgeInsets.all(20.0),
					child: new Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[

							new Center(
									child: new Text('Bienvenido', style: Theme
											.of(context)
											.textTheme
											.display1)
							),

							new Center(
									child: new Text(username, style: Theme
											.of(context)
											.textTheme
											.display1)
							),


						],
					),
				)
		);
	}


}
