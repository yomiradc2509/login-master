import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solologin/screens/cambiopass.dart';
import 'package:solologin/screens/forgotpass.dart';
import 'package:solologin/screens/principal.dart';
import 'package:solologin/utilities/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  var datosUsuario;

  final TextEditingController usuarioController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

//TExTOOO

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Usuario',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              controller: usuarioController,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4.0),
                hintText: ' Ingrese su usuario',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          //CONTRASEÑAAA
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Contraseña',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4.0),
                hintText: ' Ingrese su contraseña',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

//AAAAAAA

  Container _buildForgotPasswordBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassScreen()),
          );
        },
        padding: EdgeInsets.only(right: 15.0),
        child: Text(
          'Olvidé mi contraseña',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Container _buildCambiarPassBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CambioPassScreen()),
          );
        },
        padding: EdgeInsets.only(right: 11.0),
        child: Text(
          'Quiero cambiar mi contraseña',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  signIn(String usuario, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse;
    var response = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/buscar/" +
            usuario +
            "/" +
            pass);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        print(jsonResponse);
        Navigator.push(context,MaterialPageRoute(builder: (context) => PrincipalScreen(jsonResponse: jsonResponse,)),);

        print(jsonResponse);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Algo salió mal!"),
            content: new Text(
                "Tu usuario o contraseña incorrectos. Vuelve a intentarlo."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

//h

  Container _buildLoginBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      //width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 23.0),
      //width: double.infinity,

      // height: 40.0,
      //padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      margin: EdgeInsets.all(15.0),
      child: RaisedButton(
        onPressed: usuarioController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(usuarioController.text, passwordController.text);
              },
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Iniciar Sesion',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

//ENCABEZADO

  Container _headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        'SIGAP',
        style: TextStyle(
            color: Colors.white70,
            fontFamily: 'OpenSans',
            fontSize: 40.0,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //Stack(
          //children: <Widget>[
          Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A237E),
              Color(0xFF3949AB),
              Color(0xFF5C6BC0),
              Color(0xFF7986CB),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  _headerSection(),
                  textSection(),
                  _buildForgotPasswordBtn(),
                  _buildLoginBtn(),
                  _buildCambiarPassBtn(),
                ],
              ),
      ),
    );
  }
}
