import 'package:flutter/material.dart';

import 'endereco_model.dart';
import 'myhomepage_bloc.dart';


class MyHomePage extends StatelessWidget {
  MyHomePageBloc bloc = MyHomePageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: "Digite seu CEP",
                  border: OutlineInputBorder()
              ),
              onChanged: (value){
                bloc.input.add(value);
              },
            ),
            Center(
              child: StreamBuilder<EnderecoModel>(
                  initialData: EnderecoModel(bairro: "Sem bairro"),
                  stream: bloc.output,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Text("Erro na pesquisa",style: TextStyle(color: Colors.red),);
                    }
                    EnderecoModel model = snapshot.data;
                    return Text('Bairro : ${model.bairro}');
                  }
              ),
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
