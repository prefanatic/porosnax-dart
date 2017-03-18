import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Poro Snax',
      theme: new ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see
      // the application has a blue toolbar. Then, without quitting
      // the app, try changing the primarySwatch below to Colors.green
      // and then invoke "hot reload" (press "r" in the console where
      // you ran "flutter run", or press Run > Hot Reload App in IntelliJ).
      // Notice that the counter didn't reset back to zero -- the application
      // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new ChampionListPage(title: 'Champions'),
    );
  }
}

class ChampionListPage extends StatefulWidget {
  ChampionListPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _ChampionListPageState createState() => new _ChampionListPageState();
}

class _ChampionItem extends StatefulWidget {
  _ChampionItem({Key key, this.champion}) : super(key: key);

  final Champion champion;

  @override
  State createState() {
    return new _ChampionItemState(
      champion: champion,
    );
  }
}

class _ChampionItemState extends State<_ChampionItem> {
  final Champion champion;

  _ChampionItemState({this.champion});

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Stack(
        children: [
          new Image.network(
            "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/${champion
                .id}_0.jpg",
            fit: BoxFit.fitWidth,
            scale: 1.8,
            alignment: new FractionalOffset(0.0, 0.16),
          ),
          new Align(
            alignment: FractionalOffset.bottomLeft,
            child: new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text(
                champion.name,
                style: new TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChampionListPageState extends State<ChampionListPage> {
  var champions = new List<Champion>();

  @override
  void initState() {
    super.initState();

    fetchChampionData((ChampionData data) {
      setState(() {
        champions.clear();
        Map tempChamps = data.data['data'];
        tempChamps.forEach((String championName, Map championData) {
          var champion = new Champion(championData);
          print("Adding ${champion.toString()}");
          champions.add(champion);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var children = new List();
    champions.map((Champion champion) =>
    new _ChampionItem(
      key: new Key(champion.id),
      champion: champion,
    ));

    children.addAll(champions);

    var championList = new GridView(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: children,
    );

    // This method is rerun every time setState is called, for instance
    // as done by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return new Scaffold(
      appBar: new AppBar (
        title: new Text (config.title),
      ),
      body: championList,
    );
  }
}
