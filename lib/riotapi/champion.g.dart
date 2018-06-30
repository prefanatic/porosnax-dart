// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champion.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Champion _$ChampionFromJson(Map<String, dynamic> json) => new Champion(
    json['key'] as String,
    json['name'] as String,
    json['title'] as String,
    json['blurb'] as String,
    json['lore'] as String,
    (json['spells'] as List)
        ?.map((e) =>
            e == null ? null : new Spell.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['skins'] as List)
        ?.map((e) =>
            e == null ? null : new Skin.fromJson(e as Map<dynamic, dynamic>))
        ?.toList());

abstract class _$ChampionSerializerMixin {
  String get key;
  String get name;
  String get title;
  String get blurb;
  String get lore;
  List<Spell> get spells;
  List<Skin> get skins;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'name': name,
        'title': title,
        'blurb': blurb,
        'lore': lore,
        'spells': spells,
        'skins': skins
      };
}
