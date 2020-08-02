import 'package:flutter/material.dart';
import 'package:solologin/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Inicio de Sesión',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
