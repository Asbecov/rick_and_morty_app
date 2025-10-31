import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/enitites/character_entity.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:hive/hive.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const String characterBoxName = "characters";

  @override
  Future<List<Character>> getCachedList() async {
    final Box characterBox = await Hive.openBox(characterBoxName);

    return characterBox.values
        .expand((e) => e)
        .map<Character>(
          (value) => CharacterEntity.fromJson(Map<String, dynamic>.from(value)),
        )
        .toList();
  }

  @override
  Future cacheCharacterPage({
    required int page,
    required List<Character> characterPage,
  }) async {
    final Box characterBox = await Hive.openBox(characterBoxName);

    if (characterPage is List<CharacterEntity>) {
      await characterBox.put(
        page,
        characterPage.map((entity) => entity.toJson()),
      );
    }
  }

  @override
  Future<List<Character>?> getCachedPage({int page = 1}) async {
    final Box characterBox = await Hive.openBox(characterBoxName);

    final data = characterBox.get(page);
    if (data == null) return null;

    return data
        .map(
          (json) => CharacterEntity.fromJson(Map<String, dynamic>.from(json)),
        )
        .toList();
  }

  @override
  Future<Character?> getCachedCharacter({required int id}) async {
    final Box characterBox = await Hive.openBox(characterBoxName);

    return characterBox.values
        .expand((e) => e)
        .map<Character>(
          (value) => CharacterEntity.fromJson(Map<String, dynamic>.from(value)),
        )
        .toList()
        .where((entity) => entity.id == id)
        .singleOrNull;
  }

  @override
  Future clearCache() => Hive.deleteBoxFromDisk(characterBoxName);
}
