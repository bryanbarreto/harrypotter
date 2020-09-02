import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Feiticos extends StatefulWidget {
  @override
  _FeiticosState createState() => _FeiticosState();
}

class _FeiticosState extends State<Feiticos> {
  makeRequest() async {
    http.Response response = await http.get(
        'https://www.potterapi.com/v1/spells?key=\$2a\$10\$DOeDX1CZNy4ZBFHTyrKOYO.buNu2syRMNrYChqMqsQIgDFs4ZyD6G');
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feitiços"),
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                leading: Image.asset(
                  'assets/feiticos.png',
                  fit: BoxFit.fitHeight,
                ),
                title: Text(
                  snapshot.data[index]['spell'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: Text(
                  "${snapshot.data[index]['type']} - ${snapshot.data[index]['effect']}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
