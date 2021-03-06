import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChapeuSeletor extends StatefulWidget {
  @override
  _ChapeuSeletorState createState() => _ChapeuSeletorState();
}

class _ChapeuSeletorState extends State<ChapeuSeletor> {
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    String msg = "Clique no botão para escolher sua escola";
    String house = "";
    Map<String, List<String>> houses = {
      "Slytherin": [
        "Sonserina",
        "https://i.pinimg.com/originals/35/38/05/353805a6f80434f1d227d7dc4250d1a5.jpg",
        "A casa Sonserina é conhecida por possuir os membros mais ambiciosos, calculistas e orgulhosos.Foi fundada pelo famoso bruxo Salazar Slytherin, Tem como membros memoráveis:Tom Riddle, Regulus Black, Bellatrix Lestrange e Severo Snape. Também era a casa de Draco Malfoy e até de Lúcio Malfoy"
      ],
      "Gryffindor": [
        "Grifinória",
        "https://vignette.wikia.nocookie.net/harrypotter/images/0/06/G_final_%281%29.jpg/revision/latest/top-crop/width/360/height/450?cb=20121116012731&path-prefix=pt-br",
        "Os membros da Griffinória são conhecidos por sua coragem e lealdade. Foi fundada pelo famoso bruxo da época, o poderoso Godric Gryffindor Esta é a casa de:  Harry Potter, Gina Weasley, Rony Weasley e Hermione, toda a Família Weasley (irmãos de Rony), além de Neville Longbottom e vários outros personagens."
      ],
      "Ravenclaw": [
        "Corvinal",
        "https://vignette.wikia.nocookie.net/harrypotter/images/0/07/Ravenclaw_%28S%C3%ADmbolo_Corvinal%29.png/revision/latest/top-crop/width/360/height/450?cb=20170324224938&path-prefix=pt-br",
        "Corvinal é a casa daqueles que tem uma grande capacidade intelectual, ou até mesmo os que são focados nos estudos. Foi fundada pelo bruxa Rowena Revenclaw. Tem como membros mais famosos: Luna Lovegood, Cho-Chang e Padma Patil "
      ],
      "Hufflepuff": [
        "Lufa-Lufa",
        "https://vignette.wikia.nocookie.net/harrypotter/images/0/06/Hufflepuff_ClearBG.png/revision/latest/window-crop/width/200/x-offset/0/y-offset/0/window-width/350/window-height/350?cb=20200612012838&path-prefix=pt-br",
        "A Casa Lufa-Lufa tem como membros os mais gentis, pacientes e tolerantes alunos. Foi fundada pelo bruxa Helga Hufflepuff. Tem como alunos marcantes: Cedrico Diggory(participou do torneio tribruxo, mas “morreu” na sua primeira aparição nos filmes), Ninfadora Tonks e a professora de Hogwarts Pomona Sprout"
      ],
    };

    makeRequest() async {
      setState(() {
        this.isDisabled = true;
      });

      var url =
          "https://www.potterapi.com/v1/sortingHat?key=\$2a\$10\$DOeDX1CZNy4ZBFHTyrKOYO.buNu2syRMNrYChqMqsQIgDFs4ZyD6G";
      var response = await http.get(url);
      var house = json.decode(response.body);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              houses[house][0],
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 200,
                  child: Image.network(
                    houses[house][1],
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  houses[house][2],
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      isDisabled = false;
                    });
                  },
                  child: Text("Ok"))
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chapéu Seletor'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 100,
                child: Image.asset(
                  'assets/chapeu-seletor.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 44,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Qual escola combina comigo?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: isDisabled ? null : makeRequest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
