import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CasasDetail extends StatelessWidget {
  final String id;
  final String houseName;
  String colors = "";

  Map<String, String> mascots = {
    "lion": "grifinoria",
    "eagle": "corvinal",
    "serpent": "sonserina",
    "badger": "lufalufa"
  };

  CasasDetail({@required this.id, @required this.houseName}) {}

  makeRequest() async {
    http.Response response = await http.get(
        'https://www.potterapi.com/v1/houses/${this.id}?key=\$2a\$10\$DOeDX1CZNy4ZBFHTyrKOYO.buNu2syRMNrYChqMqsQIgDFs4ZyD6G');

    return json.decode(response.body);
  }

  _buildRow({
    @required BuildContext context,
    @required String title,
    @required String text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "${title} ",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.houseName),
      ),
      body: FutureBuilder(
        future: makeRequest(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          for (String color in snapshot.data[0]['colors']) {
            this.colors += "$color, ";
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height / 8,
                child: Image.asset(
                    "assets/${this.mascots[snapshot.data[0]['mascot']]}.png"),
              ),
              SizedBox(
                height: 20,
              ),
              _buildRow(
                context: context,
                title: "Nome:",
                text: snapshot.data[0]['name'],
              ),
              _buildRow(
                context: context,
                title: "Fundador:",
                text: snapshot.data[0]['founder'],
              ),
              _buildRow(
                context: context,
                title: 'Diretor(a):',
                text: snapshot.data[0]['headOfHouse'],
              ),
              _buildRow(
                context: context,
                title: "Fantasma:",
                text: snapshot.data[0]['houseGhost'],
              ),
              _buildRow(
                context: context,
                title: "Membros:",
                text: snapshot.data[0]['members'].length.toString(),
              ),
              _buildRow(
                context: context,
                title: "Cores:",
                text: this.colors,
              ),
            ],
          );
        },
      ),
    );
  }
}
