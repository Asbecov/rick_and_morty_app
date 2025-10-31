import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract interface class LocalDataSource {
  Future<List<Character>> getCachedList();

  Future<List<Character>?> getCachedPage({int page = 1});

  Future<Character?> getCachedCharacter({required int id});

  Future cacheCharacterPage({
    required int page,
    required List<Character> characterPage,
  });

  Future clearCache();
}
