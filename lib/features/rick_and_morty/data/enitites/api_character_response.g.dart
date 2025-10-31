// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_character_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiCharacterResponse _$ApiCharacterResponseFromJson(
  Map<String, dynamic> json,
) => ApiCharacterResponse(
  results: (json['results'] as List<dynamic>)
      .map((e) => CharacterEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ApiCharacterResponseToJson(
  ApiCharacterResponse instance,
) => <String, dynamic>{'results': instance.results};
