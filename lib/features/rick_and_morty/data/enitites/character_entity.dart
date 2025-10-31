import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part "character_entity.g.dart";

@JsonSerializable()
class CharacterEntity implements Character {
  @override
  final String gender;
  @override
  final int id;
  @override
  final String imageUrl;
  @override
  final String name;
  @override
  final String status;

  const CharacterEntity({
    required this.id,
    required this.gender,
    required this.name,
    required this.status,
    // ignore: invalid_annotation_target
    @JsonKey(name: "image") required this.imageUrl,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);
}
