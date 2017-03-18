import 'dart:convert';
import 'dart:io';

class Champion {
  Champion(Map data)
      : id = data["id"],
        name = data["name"],
        title = data["title"],
        blurb = data["blurb"];

  final String id, name, title, blurb;

  @override
  String toString() =>
      "Champion(id{$id}, name{$name})";
}

class ChampionData {
  ChampionData(this.data) {
    Map d = data['data'];

    d.forEach((String championName, Map championData) {
      var champion = new Champion(championData);
      print("Adding ${champion.toString()}");

      champions.add(champion);
    });
  }

  final Map data;
  List<Champion> champions = new List();

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

loadingImage(String key) =>
    "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/${key}_0.jpg";