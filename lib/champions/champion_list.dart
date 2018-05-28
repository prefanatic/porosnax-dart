import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:porosnax_dart/data.dart';
import 'package:porosnax_dart/image.dart';
import 'package:porosnax_dart/palette.dart';
import 'package:porosnax_dart/riotapi/riotapi.dart';

class ChampionListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Champions"),
      ),
      body: new FutureBuilder(
        future: RiotStaticApi.instance.staticData.champions(),
        builder:
            (BuildContext context, AsyncSnapshot<ChampionsPayload> snapshot) {
          if (snapshot.hasData) {
            List<Champion> sortedChampions = snapshot.data.data.values.toList()
              ..sort((a, b) => a.name.compareTo(b.name));

            return new GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, index) {
                var champion = sortedChampions[index];
                return _ChampionItem(
                  champion: champion,
                );
              },
            );
          }

          if (snapshot.hasError) {
            return new Center(
              child: new Column(
                children: <Widget>[
                  new FlutterLogo(),
                  new Text(snapshot.error.toString()),
                ],
              ),
            );
          }

          return new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _ChampionItem extends StatefulWidget {
  _ChampionItem({Key key, this.champion}) : super(key: key);

  final Champion champion;

  @override
  State createState() {
    return new _ChampionItemState();
  }
}

class _ChampionItemState extends State<_ChampionItem> {
  Color color = Colors.black45;

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  _generatePaletteForBytes(Uint8List bytes) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // no-op: palette not implemented.
      return;
    }

    this.color = await Palette.instance.generate(bytes);

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/champion/${widget.champion.key}");
      },
      child: new Tooltip(
        message: widget.champion.name,
        child: new GridTile(
          child: new ClipRect(
            child: new Align(
              alignment: Alignment.center,
              child: new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.none,
                    alignment: new FractionalOffset(0.5, 0.16),
                    image: new NetworkCalloutImage(
                      loadingImage(widget.champion.key),
                      callback: _generatePaletteForBytes,
                    ),
                  ),
                ),
              ),
            ),
          ),
          footer: new GridTileBar(
            backgroundColor: color,
            title: new Text(
              widget.champion.name,
              style: new TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
