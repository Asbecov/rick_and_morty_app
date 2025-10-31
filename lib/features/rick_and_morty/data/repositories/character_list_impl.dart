import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/remote/remote_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/repositories/character_list.dart';

class CharacterListRepositoryImpl implements CharacterListRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  const CharacterListRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Character> getCharacter({required int id}) {
    // TODO: implement getCharacter
    throw UnimplementedError();
  }

  @override
  Future<List<Character>> getList({int page = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }
}
