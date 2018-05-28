import 'package:flutter/material.dart';
import 'package:porosnax_dart/champions/champion.dart';
import 'package:porosnax_dart/champions/champion_list.dart';
import 'package:porosnax_dart/riotapi/riotapi.dart';

void main() {
  MaterialPageRoute.debugEnableFadingRoutes = true;

  runApp(new PoroSnax());
}

class PoroSnax extends StatelessWidget {
  // This widget is the root of your application.
  final _champions = new Map<String, Champion>();

  Route<Null> _getRoute(RouteSettings settings) {
    final List<String> path = settings.name.split('/');
    if (path[0] != '') return null;
    if (path[1] == 'champion') {
      if (path.length != 3) return null;
      return new MaterialPageRoute<Null>(
        settings: settings,
        builder: (BuildContext context) =>
            new ChampionPage(championKey: path[2]),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Poro Snax',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      onGenerateRoute: _getRoute,
      routes: {
        "/": (context) => new ChampionListPage(),
      },
    );
  }
}
