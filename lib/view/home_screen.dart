import 'package:HP/view/casas.dart';
import 'package:HP/view/chapeu_seletor.dart';
import 'package:HP/view/personagens.dart';
import 'package:flutter/material.dart';

import 'feiticos.dart';

class HomeScreen extends StatelessWidget {
  Widget _buildButton(
      {@required BuildContext context,
      @required imageUrl,
      @required Function onPressed}) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: RaisedButton(
        padding: EdgeInsets.all(10),
        color: Theme.of(context).accentColor,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.contain,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton(
                    context: context,
                    imageUrl: 'assets/chapeu-seletor.png',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ChapeuSeletor();
                          },
                        ),
                      );
                    },
                  ),
                  _buildButton(
                    context: context,
                    imageUrl: 'assets/casas-hogwarts.png',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Casas();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton(
                    context: context,
                    imageUrl: 'assets/feiticos.png',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Feiticos();
                          },
                        ),
                      );
                    },
                  ),
                  _buildButton(
                    context: context,
                    imageUrl: 'assets/personagens.png',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Personagens();
                          },
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
