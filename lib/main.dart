import 'package:flutter/material.dart';

import 'data.dart';
import 'champion.dart';

void main() {
  runApp(new PoroSnax());
}

class PoroSnaxState extends State<PoroSnax> {
  // This widget is the root of your application.
  final _champions = new Map<String, Champion>();

  Route<Null> _getRoute(RouteSettings settings) {
    final List<String> path = settings.name.split('/');
    if (path[0] != '')
      return null;
    if (path[1] == 'champion') {
      if (path.length != 3)
        return null;
      if (_champions.containsKey(path[2])) {
        return new MaterialPageRoute<Null>(
            settings: settings,
            builder: (BuildContext context) =>
            new ChampionPage(champion: _champions[path[2]])
        );
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    fetchChampionData((ChampionData data) {
      setState(() {
        _champions.clear();

        data.champions.forEach((Champion champion) {
          _champions[champion.id] = champion;
        });
      });
    });
  }


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
      home: new ChampionListPage(title: 'Champions', champions: _champions),
      onGenerateRoute: _getRoute,
    );
  }
}

class PoroSnax extends StatefulWidget {
  @override
  State createState() => new PoroSnaxState();
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
    return new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/champion/${champion.id}");
        },
        child: new Tooltip(
          message: champion.name,
          child: new GridTile(
            child: new Image.network(
              loadingImage(champion.id),
              fit: BoxFit.fitWidth,
              scale: 1.8,
              alignment: new FractionalOffset(0.0, 0.16),
            ),
            footer: new GridTileBar(
              backgroundColor: Colors.black45,
              title: new Text(
                champion.name,
                style: new TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
    );
  }
}

class ChampionListPage extends StatefulWidget {
  ChampionListPage({Key key, this.title, this.champions}) : super(key: key);

  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;
  final Map<String, Champion> champions;

  @override
  _ChampionListPageState createState() => new _ChampionListPageState();
}

class _ChampionListPageState extends State<ChampionListPage> {
  @override
  Widget build(BuildContext context) {
    var children = new List<_ChampionItem>();

    if (config.champions != null) {
      config.champions.forEach((String id, Champion champion) {
        var item = new _ChampionItem(
          key: new Key(champion.id),
          champion: champion,
        );
        children.add(item);
      });
    }

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
