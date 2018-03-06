import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

	LoginPage({
		Key key,
		this.title,
		@required this.onSubmit,
	}) : super(key: key);

	final String title;
	final VoidCallback onSubmit;

	@override
	_MyLoginState createState() => new _MyLoginState();
}

class _MyLoginState extends State<LoginPage> {

	static final TextEditingController _username = new TextEditingController();
	static final TextEditingController _password = new TextEditingController();

	String get username => _username.text;

	String get password => _password.text;

	String alert = '';
	bool statusLogin = true;

	@override
	void initState() {
		super.initState();
	}

	/* Validar Email */
	void _validarEmail() {
		if (username == null || username.isEmpty) {
			alert = 'El usuario es obligatorio.';
			statusLogin = false;
		}
		else {
			statusLogin = true;
		}
	}

	/* Validar Contraseña */
	void _validarPassword() {
		if (password == null || password.isEmpty) {
			alert = 'La Contraseña es obligatoria.';
			statusLogin = false;
		}
		else {
			statusLogin = true;
		}
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
											child: new Text("Iniciando..."),
										),
									])
							,),
					],
				),
			),
		);
	}

	/*Metodo de Acceso*/
	void _setAutenticar() {
		setState(() {
			_validarPassword();
			_validarEmail();

			if (statusLogin == true) {
				_onLoading();
				_loginButton();
			}
			else {
				showDialog(
					context: context,
					child: new AlertDialog(
						title: new Text('Error'),
						content: new Text(alert),
					),
				);
			}
		});
	}

	/* Metodo de Validacion y Acceso */
	_loginButton() async {
		var httpClient = new HttpClient();
		SharedPreferences prefs = await SharedPreferences.getInstance();
		var respuesta;

		try {
			var uri = new Uri.https('zarotransportation.com', '/ram/wsclientes/login',
					{'usuario': _username.text, 'contrasenia': _password.text});
			print(uri.toString());
			var request = await httpClient.getUrl(uri);
			var response = await request.close();

			if (response.statusCode == HttpStatus.OK) {
				var json = await response.transform(UTF8.decoder).join();
				var data = JSON.decode(json);

				if (data['estado'] != '') {
					respuesta = true;
				}
				else {
					respuesta = false;
				}
			}
			else {
				respuesta = response.statusCode;
			}
		}
		catch (e) {
			print(e.toString());
			respuesta = 0;
		}

		setState(() {
			if (respuesta == true) {
				prefs.setString('_username', username);
				//runApp(new PrincipalApp());

				Navigator.of(context).pushNamedAndRemoveUntil(
						'/Principal', (Route<dynamic> rout) => false);
			}
			else if (respuesta == false) {
				showDialog(
					context: context,
					child: new AlertDialog(
						title: new Text('Acceso'),
						content: new Text('Usuario y/o Contraseña Incorrectos'),
					),
				);
			}
			else if (respuesta == 0) {
				showDialog(
					context: context,
					child: new AlertDialog(
						title: new Text('Conexión'),
						content: new Text(
								'Problemas con la conexión al servidor, intentelo nuevamente.'),
					),
				);
			}
			else {
				showDialog(
					context: context,
					child: new AlertDialog(
						title: new Text('Conexión'),
						content: new Text(
								'Problemas con la conexión al servidor.' + respuesta),
					),
				);
			}
		});
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
				body: new Container(
					padding: new EdgeInsets.all(20.0),
					decoration: new BoxDecoration(
						image: new DecorationImage(
							image: new AssetImage("assets/images/bg_login.png"),
							fit: BoxFit.cover,
						),
					),

					child: new Column(
						mainAxisAlignment: MainAxisAlignment.end,
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: <Widget>[

							new Container(
								child: new TextField(
									controller: _username,
									keyboardType: TextInputType.emailAddress,
									decoration: new InputDecoration(
										hintText: 'USUARIO',
									),
								),
								margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
							),

							new Container(
								child: new TextField(
									controller: _password,
									obscureText: true,
									decoration: new InputDecoration(
										hintText: 'CONTRASEÑA',
									),
								),
								margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
							),

							new Container(
								child: new RaisedButton(
									child: new Text('INICIAR'),
									color: Colors.red,
									textColor: Colors.white,
									textTheme: ButtonTextTheme.accent,
									onPressed: () {
										_setAutenticar();
									},
								),
								margin: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
							),

						],

					),
				)

		);
	}

}
