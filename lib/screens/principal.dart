import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solologin/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class PrincipalScreen extends StatefulWidget {
  @override
 final Map jsonResponse;
  PrincipalScreen({Key key, @required this.jsonResponse}) : super(key: key);
  _PrincipalScreenState createState() => new _PrincipalScreenState(jsonResponse);
}

class _PrincipalScreenState extends State<PrincipalScreen> {
Map jsonResponse;
_PrincipalScreenState(this.jsonResponse);
  List data;
  List pagosData;
  getData() async {
    http.Response response = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/alumnoprograma/buscard/"+"${jsonResponse["dniM"]}");

    data = json.decode(response.body);
    setState(() {
      pagosData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

   Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Lista de Programas'),
          backgroundColor: Colors.indigo[900],
        ),
        body: Column(
          children: [
            Row(children: [
              Expanded(
                child: Text('    N',
                    style: TextStyle(
                      height: 2.0,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Expanded(
                child: Text('Programa',
                    style: TextStyle(
                      height: 2.0,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              
              Expanded(
                child: Text(' ',
                    style: TextStyle(
                      height: 3.0,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ]),
            Expanded(
              child: Container(
                  child: ListView.builder(
                itemCount: pagosData == null ? 0 : pagosData.length,
                itemBuilder: (BuildContext context, int index) {
                  index = index + 1;
                  return Card(
                      child: Padding(
                          padding: const EdgeInsets.all(8.6),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.6),
                                child: Text(
                                  "$index",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                    "${pagosData[index - 1]["nom_programa"]}",
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400),
                                  )),
                              
  
                              
                            ],
                          )));
                },
              )),
            )
          ],
        ));
  }
}