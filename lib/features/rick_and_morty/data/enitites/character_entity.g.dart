// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterEntity _$CharacterEntityFromJson(Map<String, dynamic> json) =>
    CharacterEntity(
      id: (json['id'] as num).toInt(),
      gender: json['gender'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      imageUrl: json['image'] as String,
    );

Map<String, dynamic> _$CharacterEntityToJson(CharacterEntity instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'id': instance.id,
      'image': instance.imageUrl,
      'name': instance.name,
      'status': instance.status,
    };
