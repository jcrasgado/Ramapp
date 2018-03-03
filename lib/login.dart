import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
	LoginPage({Key key, this.title}) : super(key: key);

	final String title;

	@override
	_MyLoginState createState() => new _MyLoginState();
}

class _MyLoginState extends State<LoginPage> { 

	final TextEditingController _username = new TextEditingController();
	final TextEditingController _password = new TextEditingController();

	final GlobalKey<FormFieldState<String>> _usernameFieldKey = new GlobalKey<FormFieldState<String>>();
	final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<FormFieldState<String>>();    

	bool _validarEmail() {

		String alert = '';

		if(_username.text == null || _username.text.isEmpty)
		{
			alert = 'El usuario es obligatorio.';
		}

		if(!_username.text.contains('@'))
		{
			alert = 'El usuario no es un email valido.';
		}

		if(alert != '')
		{
			showDialog( 
			context: context,
			child: new AlertDialog(
					title: new Text('Error'),
                    content: new Text(alert),
				),
			);

			return false;
		}
		else
		{
			return true;
		}		
	}

  	bool _validarPassword() {

		String alert = '';

		if(_username.text == null || _username.text.isEmpty)
		{
			alert = 'La Contraseña es obligatoria.';
		}

		if(alert != '')
		{
			showDialog( 
			context: context,
			child: new AlertDialog(
					title: new Text('Error'),
                    content: new Text(alert),
				),
			);

			return false;
		}
		else
		{
			return true;
		}	
  	}

      void _onLoading() {
          
        showDialog(
            context: context,
            barrierDismissible: false,
            child: new Dialog(                
                child: new Row(                    
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget> [
                        new Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget> [
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
        new Future.delayed(new Duration(seconds: 3), () {
            Navigator.pop(context); //pop dialog
            _loginButton();
        });
    }
    
    _loginButton() async {
        
        if (_validarEmail() && _validarPassword() )
		{
            var httpClient = new HttpClient();
            var respuesta;

            try 
            {
                var uri = new Uri.https( 'zarotransportation.com', '/ram/wsclientes/login', {'usuario': _username.text, 'contrasenia': _password.text});
                print(uri.toString());
                var request = await httpClient.getUrl(uri);
                var response = await request.close();
                
                if (response.statusCode == HttpStatus.OK) 
                {
                    var json = await response.transform(UTF8.decoder).join();
                    var data = JSON.decode(json);

                    if( data['estado'] == true)
                    {
                        respuesta = true;
                    }
                    else
                    {
                        respuesta = false;
                    }
                } 
                else 
                {
                    respuesta = response.statusCode;
                }
            } 
            catch (e)
            {
                print(e.toString());
                respuesta = 0;
            }

            setState(() {
                if (respuesta == false)
                {
                    showDialog( 
                        context: context,
                        child: new AlertDialog(
                                title: new Text('Acceso'),
                                content: new Text('Usuario y/o Contraseña Incorrectos'),
                            ),
                    );
                }
                else if (respuesta == 0)
                {
                    showDialog( 
                        context: context,
                        child: new AlertDialog(
                                title: new Text('Conexión'),
                                content: new Text('Problemas con la conexión al servidor, intentelo nuevamente.'),
                            ),
                    );
                }
                else
                {
                    showDialog( 
                        context: context,
                        child: new AlertDialog(
                                title: new Text('Conexión'),
                                content: new Text('Problemas con la conexión al servidor.'+ respuesta),
                            ),
                    );
                }
            });
        }
        
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
						key: _usernameFieldKey,
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
						key: _passwordFieldKey,
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
					onPressed: (){ _onLoading();
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
