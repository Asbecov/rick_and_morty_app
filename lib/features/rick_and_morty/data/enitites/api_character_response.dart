import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/enitites/character_entity.dart';

part 'api_character_response.g.dart';

@JsonSerializable()
class ApiCharacterResponse {
  const ApiCharacterResponse({required this.results});

  final List<CharacterEntity> results;

  factory ApiCharacterResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiCharacterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiCharacterResponseToJson(this);
}
