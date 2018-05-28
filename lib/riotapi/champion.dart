import 'package:json_annotation/json_annotation.dart';

part 'champion.g.dart';

@JsonSerializable()
class Champion extends Object with _$ChampionSerializerMixin {
  final String key, name, title, blurb, lore;

  Champion(this.key, this.name, this.title, this.blurb, this.lore);

  String get loadingImage =>
      "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/${key}_0.jpg";

  String splashImage([int skin = 0]) {
    return "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${key}_$skin.jpg";
  }

  @override
  String toString() => "Champion(key{$key}, name{$name})";

  factory Champion.fromJson(Map<String, dynamic> json) =>
      _$ChampionFromJson(json);
}
