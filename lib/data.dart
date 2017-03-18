import 'dart:convert';
import 'dart:io';

class Champion {
  Champion(Map data)
      : id = data["id"],
        name = data["name"];

  final String id, name;

  @override
  String toString() =>
      "Champion(id{$id}, name{$name})";
}

class ChampionData {
  Map data;

  ChampionData(Map data) {
    this.data = data;
  }

}

typedef void ChampionDataCallback(ChampionData data);

fetchChampionData(ChampionDataCallback callback) async {
  HttpClient client = new HttpClient();
  var uri = Uri.parse(
      "https://ddragon.leagueoflegends.com/cdn/7.5.2/data/en_US/champion.json");
  var request = await client.getUrl(uri);
  var response = await request.close();
  var data = await response.transform(UTF8.decoder).join();
  var jsonData = await JSON.decode(data);
  print(jsonData);
  client.close();

  assert(jsonData is Map);

  var dDragonVersion = jsonData['version'];
  var dDragonChampions = (jsonData['data'] as Map).length;
  print("DataDragon Version is $dDragonVersion"
      " - Contains $dDragonChampions champions.");

  callback(new ChampionData(jsonData));
}
