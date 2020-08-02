import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:solologin/utilities/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CambioPassScreen extends StatefulWidget {
  @override
  _CambioPassScreenState createState() => _CambioPassScreenState();
}

class _CambioPassScreenState extends State<CambioPassScreen> {
  bool _isLoading = false;
  var datosUsuario;

  final TextEditingController usuarioController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController pass1Controller = new TextEditingController();

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
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 45.0,
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
          SizedBox(height: 15.0),
          //EMAIL
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 45.0,
            child: TextFormField(
              controller: emailController,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4.0),
                hintText: ' Ingrese email',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          //NUEVA CONTRASEÑA
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nueva contraseña',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 45.0,
            child: TextFormField(
              controller: passController,
              obscureText: true,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4.0),
                hintText: ' Ingrese nueva contraseña',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          //NUEVA CONTRASEÑA CONFIRMAA
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Confirmar nueva contraseña',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 45.0,
            child: TextFormField(
              controller: pass1Controller,
              obscureText: true,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4.0),
                hintText: ' Ingrese nueva contraseña',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

//AAAAAAA

  Container _buildInicioBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.only(right: 11.0),
        child: Text(
          'Quiero iniciar sesión',
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

  cambiar(String usuario, String email, String pass, String pass1) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse;

    if (pass == pass1) {
      var response = await http.get(
          "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/actualizar/" +
              usuario +
              "/" +
              email +
              "/" +
              pass);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });

          print(jsonResponse);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Se cambió la contraseña."),
                content: new Text(""),
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
                  "Tu usuario o email incorrectos. Vuelve a intentarlo."),
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
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Algo salió mal!"),
            content: new Text("Las contraseñas deben coincidir."),
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

  Container _buildCambiarBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      //width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 23.0),
      margin: EdgeInsets.all(15.0),
      child: RaisedButton(
        onPressed: usuarioController.text == "" ||
                emailController.text == "" ||
                passController.text == "" ||
                pass1Controller.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                cambiar(usuarioController.text, emailController.text,
                    passController.text, pass1Controller.text);
              },
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'CAMBIAR',
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
      margin: EdgeInsets.only(top: 25.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        'Cambiar Contraseña',
        style: TextStyle(
            color: Colors.white70,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
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
                  _buildCambiarBtn(),
                  _buildInicioBtn(),
                ],
              ),
      ),
    );
  }
}
