
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'endereco_model.dart';

class MyHomePageBloc{
//  int counter = 0;
//
//  final StreamController _streamController = StreamController();
//  //Entrada de dados é chamada de sync
//  //Saída de dados é chamada de stream
//  Sink get input => _streamController.sink;
//  Stream get output => _streamController.stream;
//
//  void incrementCounter() {
//      counter++;
//      input.add(counter);
//  }
  final StreamController<String> _streamController = StreamController<String>();
  Sink<String> get input => _streamController.sink;
  Stream<EnderecoModel> get output => _streamController.stream.where((cep)=>cep.length>7).asyncMap((cep){
    return _searchCep(cep);
  });


  String url(String cep) => "http://viacep.com.br/ws/$cep/json/";

  Future<EnderecoModel> _searchCep(String cep) async{
   http.Response response =  await http.get(url(cep));
   return EnderecoModel.fromJson(json.decode(response.body));
  }
}