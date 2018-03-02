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
  
  void _loginButton() {

    showDialog( context: context,
                child: new AlertDialog(
                  title: new Text('Usuario y Contrseña'),
                  content: new Text(_username.text +' - '+ _password.text),
                ),
              );

    print("Login from Page");
    print(_password);
    print(_username);
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
                  key: new Key('_usuario'),
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
                  key: new Key('_password'),
                  controller: _password,                  
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
                onPressed: (){ _loginButton();
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
