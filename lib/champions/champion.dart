import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:porosnax_dart/image.dart';
import 'package:porosnax_dart/palette.dart';
import 'package:porosnax_dart/riotapi/riotapi.dart' as data;

class ChampionPage extends StatefulWidget {
  ChampionPage({Key key, this.championKey}) : super(key: key);

  final String championKey;

  @override
  _ChampionPageState createState() => new _ChampionPageState();
}

class _ChampionPageState extends State<ChampionPage>
    with TickerProviderStateMixin {
  data.Champion champion;

  final List<Color> accentColors = new List(3);

  int activePage = 0;
  Color activeAccentColor = Colors.blueAccent;

  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _generateAccentForSplash(int index, Uint8List bytes) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // no-op: palette not working.
      return;
    }

    Color color = await Palette.instance.generate(bytes);
    accentColors[index] = color;

    if (index == activePage) {
      setState(() {
        activeAccentColor = color;
      });
    }
  }

  void _onSkinChanged(int index) {
    activePage = index;
    //if (accentColors.length < index) return;

    setState(() {
      activeAccentColor = accentColors[index];
    });
  }

  List<Widget> _buildImagesForSkins() {
    List<Widget> images = new List();

    for (var i = 0; i < 3; i++) {
      images.add(
        new Image(
          image: new NetworkCalloutImage(
            champion.splashImage(i),
            callback: (bytes) => _generateAccentForSplash(i, bytes),
          ),
        ),
      );
    }

    return images;
  }

  LoreType loreType = LoreType.abridged;

  String get loreContent =>
      loreType == LoreType.full ? champion.blurb : champion.lore;

  void onLoreTap() {
    loreType =
        loreType == LoreType.abridged ? LoreType.full : LoreType.abridged;
    controller.reverse();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future:
          data.RiotStaticApi.instance.staticData.champion(widget.championKey),
      builder: (BuildContext context, AsyncSnapshot<data.Champion> snapshot) {
        if (snapshot.hasData) {
          this.champion = snapshot.data;

          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: activeAccentColor,
              title: new Text(champion.name),
              flexibleSpace: new FlexibleSpaceBar(),
            ),
            body: new ListView(
              children: <Widget>[
                new AspectRatio(
                  aspectRatio: 1.69,
                  child: new PageView(
                    onPageChanged: _onSkinChanged,
                    scrollDirection: Axis.horizontal,
                    children: _buildImagesForSkins(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    child: new InkWell(
                      onTap: onLoreTap,
                      child: new Container(
                        child: new Text(loreContent),
                        padding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }

        return new Scaffold(
          body: new Center(
            child: new CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class AnimatedExpansionCard extends AnimatedWidget {
  @override
  Widget build(BuildContext context) {
    return new Card();
  }
}

enum LoreType { full, abridged }
