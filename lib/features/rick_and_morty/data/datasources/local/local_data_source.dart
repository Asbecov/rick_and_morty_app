import 'dart:async';

import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract interface class LocalDataSource {
  FutureOr<List<Character>> getCachedList();

  FutureOr<List<Character>?> getCachedPage({int page = 1});

  FutureOr<Character?> getCachedCharacter({required int id});

  FutureOr cacheCharacterPage({
    required int page,
    required List<Character> characterPage,
  });

  FutureOr clearCache();
}
