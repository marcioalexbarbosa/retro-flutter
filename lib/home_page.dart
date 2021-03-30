import 'package:flip/card_api.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardModel> cards = [];

  @override
  void initState() {
    super.initState();

    CardApi.getCardList().then((cards) {
      setState(() {
        this.cards = cards;
      });
    });
  }

  _renderBg() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF99C5F3)),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0x00FFFFFF),
      ),
    );
  }

  Row _row(context, cards) {
    var cardsList = <Widget>[];

    cards.forEach((card) => {cardsList.add(_card(context, card))});

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: cardsList,
    );
  }

  List<Widget> _rows(context) {
    var rows = <Widget>[];

    int splitAt = 5;
    var temp = [];
    int index = 0;

    for (final card in cards) {
      index++;
      temp.add(card);
      if (index % splitAt == 0) {
        rows.add(_row(context, temp));
        temp.clear();
      }
    }

    return rows;
  }

  _renderContent(context) {
    var rows = _rows(context);

    return SingleChildScrollView(child: Column(children: rows));
  }

  Widget _card(context, CardModel card) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retro do Marcião'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _renderBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _renderAppBar(context),
              Expanded(
                flex: 4,
                child: _renderContent(context),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
