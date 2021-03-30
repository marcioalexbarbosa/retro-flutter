import 'package:flip/card_api.dart';
import 'package:flip/card_widget.dart';
import 'package:flutter/material.dart';

import 'card_model.dart';

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

    var cardWidget = CardWidget();

    cards.forEach((card) => {cardsList.add(cardWidget.card(context, card))});

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
