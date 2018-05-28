import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:porosnax_dart/riotapi/riotapi.dart';

part 'static_data.g.dart';

class StaticDataApi {
  static const String apiKey = "RGAPI-d9f8e5ae-c0f4-4a2a-8933-b7ed6fc0b8fc";

  StaticDataApi();

  ChampionsPayload _championPayload;

  Future<ChampionsPayload> _champions() async {
    Uri uri = new Uri.https(
        "na1.api.riotgames.com", "/lol/static-data/v3/champions", {
      "locale": "en_US",
      "champListData": "all",
      "dataById": "false",
      "api_key": apiKey,
    });

    var jsonResponse = await loadData(uri);

    Map status = jsonResponse["status"];
    if (status != null && status.isNotEmpty) {
      return new Future.error(status["message"]);
    }

    print(jsonResponse);

    _championPayload = ChampionsPayload.fromJson(jsonResponse);
    return _championPayload;
  }

  Future<ChampionsPayload> champions() async {
    return _championPayload ?? await _champions();
  }

  Future<Champion> champion(String key) async {
    return _championPayload?.data[key] ?? null;
  }
}

@JsonSerializable()
class ChampionsPayload extends Object with _$ChampionsPayloadSerializerMixin {
  final String format;
  final String type;
  final String version;
  final Map<dynamic, String> keys;
  final Map<String, Champion> data;
  final Map<dynamic, Spell> spells;

  ChampionsPayload(
      this.format, this.type, this.version, this.keys, this.data, this.spells);

  factory ChampionsPayload.fromJson(Map<String, dynamic> json) =>
      _$ChampionsPayloadFromJson(json);
}

@JsonSerializable()
class Spell extends Object with _$SpellSerializerMixin {
  final String name;
  final Image image;

  Spell(this.name, this.image);

  factory Spell.fromJson(Map<String, dynamic> json) => _$SpellFromJson(json);
}

@JsonSerializable()
class Image extends Object with _$ImageSerializerMixin {
  final String full;
  final String sprite;
  final String group;
  final int x, y, w, h;

  Image(this.full, this.sprite, this.group, this.x, this.y, this.w, this.h);

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

Future<Map> loadData(Uri uri) async {
  ReceivePort receivePort = new ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);

  // The 'echo' isolate sends its SendPort as the first message
  SendPort sendPort = await receivePort.first;

  return await sendReceive(sendPort, uri);
}

// The entry point for the isolate
dataLoader(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  ReceivePort port = new ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);

  await for (var msg in port) {
    SendPort replyTo = msg[1];

    http.Response response = await http.get(msg[0]);
    // Lots of JSON to parse
    replyTo.send(json.decode(response.body));
  }
}

Future sendReceive(SendPort port, msg) {
  ReceivePort response = new ReceivePort();
  port.send([msg, response.sendPort]);
  return response.first;
}
