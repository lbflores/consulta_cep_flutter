import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:viacep/Cep.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController pegaCep = TextEditingController();
  var resposta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Consulta CEP'),

        ),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Informe um CEP para pesquisar',

                ),
                style: TextStyle(fontSize:24),
                controller: pegaCep,
              ),
              ElevatedButton(
                child: Text('Pesquisar', style: TextStyle(fontSize:16)),
                onPressed: () => _consultaViaCep(context),
              ),
              Text('Resultado da pesquisa: \n${resposta}', style: TextStyle(fontSize:24)),
            ],
          ),
        )));
  }

  _consultaViaCep(BuildContext context) async {
    String cep = pegaCep.text;

    debugPrint('$pegaCep');
    String url = "https://viacep.com.br/ws/${cep}/json/";


    http.Response response;
    try {
      response = await http.get(Uri.parse(url));
      debugPrint('$response');
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        Cep cep = Cep.fromJson(parsedJson);

        debugPrint('imprimindo $parsedJson["logradouro"]');

        String cepVia = parsedJson["cep"];
        String logradouro = parsedJson["logradouro"];
        //String complemento = parsedJson["complemento"];
        String bairro = parsedJson["bairro"];
        //String localidade = parsedJson["localidade"];
        String uf = parsedJson["uf"];


        setState((){// forma correta para atualzar stateful
          resposta =
          "Cep: ${cepVia} \nRua: ${logradouro} \nBairro: ${bairro} \nUF: ${uf}";
        });

      } else {
        throw Exception(
            'Erro ao obter o CEP: \nSTATUSCODE: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}

