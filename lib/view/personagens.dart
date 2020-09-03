import 'dart:convert';

import 'package:HP/view/personagens_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Personagens extends StatefulWidget {
  @override
  _PersonagensState createState() => _PersonagensState();
}

class _PersonagensState extends State<Personagens> {
  makeRequest() async {
    http.Response response = await http.get(
        'https://www.potterapi.com/v1/characters/?key=\$2a\$10\$DOeDX1CZNy4ZBFHTyrKOYO.buNu2syRMNrYChqMqsQIgDFs4ZyD6G');

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personagens"),
      ),
      body: FutureBuilder(
        future: makeRequest(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/personagens.png'),
                ),
                title: Text(
                  snapshot.data[index]['name'],
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  snapshot.data[index]['house'] ?? "Casa não informada",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PersonagemDetail(
                            id: snapshot.data[index]['_id'],
                            nome: snapshot.data[index]['name']);
                      },
                    ),
                  );
                  print(snapshot.data[index]['_id']);
                },
              );
            },
          );
        },
      ),
    );
  }
}
