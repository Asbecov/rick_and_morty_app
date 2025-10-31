import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/remote/remote_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/remote/rick_and_morty_api.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/enitites/api_character_response.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final RickAndMortyApi api;

  const RemoteDataSourceImpl({required this.api});

  @override
  Future<Character> getCharacter({required int id}) async {
    try {
      final Character character = await api.getCharacter(id: id);

      return character;
    } catch (e) {
      throw Exception("Failed to fetch character: \n$e");
    }
  }

  @override
  Future<List<Character>> getList({int page = 1}) async {
    try {
      final ApiCharacterResponse response = await api.getList(page: page);
      final List<Character> characters = response.results;

      return characters;
    } catch (e) {
      throw Exception("Failed to fetch character: \n$e");
    }
  }
}
