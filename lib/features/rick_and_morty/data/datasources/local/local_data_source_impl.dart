import 'dart:async';

import 'package:hive/hive.dart';

import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/enitites/character_entity.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final Box<List<dynamic>> hiveBox;

  LocalDataSourceImpl(this.hiveBox);

  static const String characterBoxName = "characters";

  Map<int, Character> groupById(Iterable<List<dynamic>> list) {
    final List<MapEntry<int, Character>> entries = list
        .expand((e) => e)
        .map<MapEntry<int, Character>>((value) {
          final Character character = CharacterEntity.fromJson(
            Map<String, dynamic>.from(value),
          );

          return MapEntry(character.id, character);
        })
        .toList();

    return Map.fromEntries(entries);
  }

  @override
  Future cacheCharacterPage({
    required int page,
    required List<Character> characterPage,
  }) async {
    if (characterPage is! List<CharacterEntity>) return;

    await hiveBox.put(
      page,
      characterPage.map((character) => character.toJson()).toList(),
    );
  }

  @override
  Character? getCachedCharacter({required int id}) =>
      groupById(hiveBox.values)[id];

  @override
  List<Character> getCachedList() => hiveBox.values
      .expand((e) => e)
      .map<Character>(
        (value) => CharacterEntity.fromJson(Map<String, dynamic>.from(value)),
      )
      .toList();

  @override
  List<Character>? getCachedPage({int page = 1}) => hiveBox
      .get(page)
      ?.map<Character>(
        (value) => CharacterEntity.fromJson(Map<String, dynamic>.from(value)),
      )
      .toList();

  @override
  Future clearCache() => Hive.deleteBoxFromDisk(characterBoxName);
}
