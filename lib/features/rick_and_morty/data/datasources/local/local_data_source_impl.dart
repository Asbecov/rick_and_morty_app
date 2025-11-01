import 'dart:async';

import 'package:hive/hive.dart';

import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/enitites/character_entity.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const String characterBoxName = "characters";

  Box<List<dynamic>>? _characterBox;
  final Map<int, Character> _inMemoryCache = {};

  FutureOr<Box<List<dynamic>>> get _box async {
    _characterBox ??= await Hive.openBox<List<dynamic>>(characterBoxName);
    return _characterBox!;
  }

  Future _syncInMemoryCache() async {
    _inMemoryCache.clear();

    final List<Character> characters = (await _box).values
        .expand((e) => e)
        .map<Character>(
          (value) => CharacterEntity.fromJson(Map<String, dynamic>.from(value)),
        )
        .toList();

    _inMemoryCache.addEntries(
      characters.map((character) => MapEntry(character.id, character)),
    );
  }

  @override
  Future cacheCharacterPage({
    required int page,
    required List<Character> characterPage,
  }) async {
    if (characterPage is! List<CharacterEntity>) return;

    await (await _box).put(
      page,
      characterPage.map((character) => character.toJson()).toList(),
    );

    await _syncInMemoryCache();
  }

  @override
  Future<Character?> getCachedCharacter({required int id}) async {
    if (_inMemoryCache.containsKey(id)) return _inMemoryCache[id];

    await _syncInMemoryCache();

    return _inMemoryCache[id];
  }

  @override
  Future<List<Character>> getCachedList() async {
    if (_inMemoryCache.isNotEmpty) return _inMemoryCache.values.toList();

    await _syncInMemoryCache();

    return _inMemoryCache.values.toList();
  }

  @override
  Future<List<Character>?> getCachedPage({int page = 1}) async => (await _box)
      .get(page)
      ?.map<Character>(
        (value) => CharacterEntity.fromJson(Map<String, dynamic>.from(value)),
      )
      .toList();

  @override
  Future clearCache() => Hive.deleteBoxFromDisk(characterBoxName);
}
