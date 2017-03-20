import 'package:flutter/material.dart';

import 'data.dart';

class ChampionPage extends StatefulWidget {
  ChampionPage({Key key, this.champion}) : super(key: key);

  final Champion champion;

  @override
  _ChampionPageState createState() => new _ChampionPageState();
}

class _ChampionPageState extends State<ChampionPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar (
        title: new Text (config.champion.name),
      ),
    );
  }
}