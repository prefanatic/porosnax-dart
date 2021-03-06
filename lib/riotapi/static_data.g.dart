// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_data.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

ChampionsPayload _$ChampionsPayloadFromJson(Map<String, dynamic> json) =>
    new ChampionsPayload(
        json['format'] as String,
        json['type'] as String,
        json['version'] as String,
        json['keys'] == null
            ? null
            : new Map<String, String>.from(json['keys'] as Map),
        json['data'] == null
            ? null
            : new Map<String, Champion>.fromIterables(
                (json['data'] as Map<String, dynamic>).keys,
                (json['data'] as Map).values.map((e) => e == null
                    ? null
                    : new Champion.fromJson(e as Map<String, dynamic>))));

abstract class _$ChampionsPayloadSerializerMixin {
  String get format;
  String get type;
  String get version;
  Map<dynamic, String> get keys;
  Map<String, Champion> get data;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'format': format,
        'type': type,
        'version': version,
        'keys': keys,
        'data': data
      };
}

Skin _$SkinFromJson(Map<String, dynamic> json) =>
    new Skin(json['id'] as int, json['num'] as int, json['name'] as String);

abstract class _$SkinSerializerMixin {
  int get id;
  int get num;
  String get name;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'num': num, 'name': name};
}

Spell _$SpellFromJson(Map<String, dynamic> json) => new Spell(
    json['name'] as String,
    json['image'] == null
        ? null
        : new Image.fromJson(json['image'] as Map<String, dynamic>),
    json['description'] as String,
    json['cooldownBurn'] as String);

abstract class _$SpellSerializerMixin {
  String get name;
  String get description;
  String get cooldownBurn;
  Image get image;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'description': description,
        'cooldownBurn': cooldownBurn,
        'image': image
      };
}

Image _$ImageFromJson(Map<String, dynamic> json) => new Image(
    json['full'] as String,
    json['sprite'] as String,
    json['group'] as String,
    json['x'] as int,
    json['y'] as int,
    json['w'] as int,
    json['h'] as int);

abstract class _$ImageSerializerMixin {
  String get full;
  String get sprite;
  String get group;
  int get x;
  int get y;
  int get w;
  int get h;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'full': full,
        'sprite': sprite,
        'group': group,
        'x': x,
        'y': y,
        'w': w,
        'h': h
      };
}
