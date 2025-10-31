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
        .map<Character>(
          (value) => CharacterEntity.fromJson(Map<String, dynamic>.from(value)),
        )
        .toList();
  }

  @override
  Future<Character?> getCachedCharacter({required int id}) async {
    final Box characterBox = await Hive.openBox(characterBoxName);

    final data = characterBox.get(id);
    if (data == null) return null;

    return CharacterEntity.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future cacheCharacter({required Character character}) async {
    final Box characterBox = await Hive.openBox(characterBoxName);

    if (character is CharacterEntity) {
      await characterBox.put(character.id, character.toJson());
    }
  }

  @override
  Future clearCache() => Hive.deleteBoxFromDisk(characterBoxName);
}
