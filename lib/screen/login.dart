import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:crypto/crypto.dart';

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
	bool statusUser = true;
	bool statusPass = true;
	bool loading = false;

	@override
	void initState() {
		super.initState();
	}

	/* Validar Email */
	void _validarEmail() {
		if (username == null || username.isEmpty) {
			alert = 'El usuario es obligatorio.';
			statusUser = false;
		}
		else {
			statusUser = true;
		}
	}

	/* Validar Contraseña */
	void _validarPassword() {
		if (password == null || password.isEmpty) {
			alert = 'La Contraseña es obligatoria.';
			statusPass = false;
		}
		else {
			statusPass = true;
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
		new Future.delayed(new Duration(seconds: 3),);
	}

	/*Metodo de Acceso*/
	void _setAutenticar() {
		setState(() {
			_validarPassword();
			_validarEmail();

			if (statusUser == true && statusPass == true) {
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

			var pass = UTF8.encode(password);

			var uri = new Uri.https(
					'zarotransportation.com', '/fletes/wsclientes/login',
					{'usuario': username, 'contrasenia': password });

			print(uri.toString());
			var request = await httpClient.getUrl(uri);
			var response = await request.close();

			if (response.statusCode == HttpStatus.OK) {
				var json = await response.transform(UTF8.decoder).join();
				var data = JSON.decode(json);

				if (data['estado'] == "true") {
					respuesta = true;

					print(data['datos_cliente'][0]['id_cliente']);

					prefs.setString('id_cliente', data['datos_cliente'][0]['id_cliente']);
					prefs.setString('username', data['datos_cliente'][0]['username']);
					prefs.setString('nombre', data['datos_cliente'][0]['nombre']);
					prefs.setString('email', data['datos_cliente'][0]['correo']);
					prefs.setString('oficina', data['datos_cliente'][0]['oficina']);
					prefs.setString('grupo', data['datos_cliente'][0]['grupo']);
					prefs.setString('pais', data['datos_cliente'][0]['pais']);
					prefs.setString('tipo_usuario', data['datos_cliente'][0]['tipo_usuario']);
					prefs.setString('password', md5.convert(pass).toString() );

				}
				else {
					respuesta = false;
					Navigator.pop(context);
				}
			}
			else {
				respuesta = response.statusCode;
			}
		}
		catch (e) {
			print(e.toString());
			respuesta = 0;
			Navigator.pop(context);
		}

		setState(() {
			if (respuesta == true) {
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
