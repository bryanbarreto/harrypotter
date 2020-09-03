import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonagemDetail extends StatelessWidget {
  final String id;
  final String nome;

  PersonagemDetail({
    @required this.id,
    @required this.nome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.nome),
      ),
      body: Center(
        child: Text("Ainda em desenvolvimento"),
      ),
    );
  }
}
