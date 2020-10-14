import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "resultado";

  TextEditingController _controllerCep = TextEditingController();

  _recuperarCep() async {
    String cep = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = jsonDecode(response.body);

    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}, ${localidade}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de Serviço Web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCep,
            ),
            Text(_resultado),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Digite o cep ex: 05428200"),
              style: TextStyle(fontSize: 20),
              controller: _controllerCep,
            )
          ],
        ),
      ),
    );
  }
}
