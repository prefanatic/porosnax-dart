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
    json['lore'] as String);

abstract class _$ChampionSerializerMixin {
  String get key;
  String get name;
  String get title;
  String get blurb;
  String get lore;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'name': name,
        'title': title,
        'blurb': blurb,
        'lore': lore
      };
}
