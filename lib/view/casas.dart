import 'dart:convert';

import 'package:HP/view/casas_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Casas extends StatefulWidget {
  @override
  _CasasState createState() => _CasasState();
}

class _CasasState extends State<Casas> {
  Map<String, String> mascots = {
    "lion": "grifinoria",
    "eagle": "corvinal",
    "serpent": "sonserina",
    "badger": "lufalufa"
  };

  makeRequest() async {
    http.Response response = await http.get(
        'https://www.potterapi.com/v1/houses/?key=\$2a\$10\$DOeDX1CZNy4ZBFHTyrKOYO.buNu2syRMNrYChqMqsQIgDFs4ZyD6G');

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Casas"),
      ),
      body: FutureBuilder(
        future: makeRequest(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                      "assets/${mascots[snapshot.data[index]['mascot']]}.png"),
                ),
                title: Text(
                  snapshot.data[index]['name'],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  snapshot.data[index]['founder'],
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CasasDetail(
                          id: snapshot.data[index]['_id'],
                          houseName: snapshot.data[index]['name'],
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
