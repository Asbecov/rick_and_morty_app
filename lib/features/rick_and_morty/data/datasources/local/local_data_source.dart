import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract interface class LocalDataSource {
  Future<List<Character>> getCachedList();

  Future<Character?> getCachedCharacter({required int id});

  Future cacheCharacter({required Character character});

  Future clearCache();
}
