import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

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

class _ChampionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Stack(
        children: [
          new Image.network(
            "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/Azir_0.jpg",
            fit: ImageFit.fitWidth,
            scale: 1.5,
            alignment: new FractionalOffset(0.0, 0.16),
          ),
          new Align(
            alignment: FractionalOffset.bottomLeft,
            child: new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text("Hello"),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChampionListPageState extends State<ChampionListPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If we changed _counter without calling
      // setState(), then the build method would not be called again,
      // and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    HttpClient client = new HttpClient();
    client.getUrl(Uri.parse("https://ddragon.leagueoflegends.com/cdn/7.5.2/data/en_US/champion.json"))
    .then((HttpClientRequest request) {

      request.close();
    })
    .then((HttpClientResponse response) {


    });

    var champions = new List();

    for (var i = 0; i < 10; i++) {
      champions.add(new _ChampionItem());
    }

    var championList = new GridView(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: champions,
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
