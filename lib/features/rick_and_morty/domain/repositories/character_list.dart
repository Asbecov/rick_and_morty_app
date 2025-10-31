import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract interface class CharacterListRepository {
  Future<List<Character>> getList({int page = 1});

  Future<Character> getCharacter({required int id});
}
