import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'card_model.dart';

class CardWidget {
  Widget card(context, CardModel card) {
    return Expanded(
        flex: 1,
        child: Card(
          elevation: 0.0,
          margin:
          EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
          color: Color(0x00000000),
          child: FlipCard(
            key: UniqueKey(),
            direction: FlipDirection.HORIZONTAL,
            speed: 1500,
            front: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(250, 1, 128, 96),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(card.front,
                      style: Theme.of(context).textTheme.headline5),
                  Text('surprise me',
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            back: Container(
              height: 200,
              decoration: BoxDecoration(
                color: card.serious
                    ? Color.fromARGB(250, 208, 198, 7)
                    : Color.fromARGB(250, 75, 210, 45),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Text(card.back,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:
                          card.serious ? Colors.black : Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage(
                          card.serious ?
                          "images/scream.png" :
                          "images/relief.png"
                      ),
                      height: 40,
                      width: 40,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}