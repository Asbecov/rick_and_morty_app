import 'package:dartz/dartz.dart';

import 'package:rick_and_morty_app/common/domain/errors/failures.dart';
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
  Future<Either<Failure, Character>> getCharacter({required int id}) async {
    try {
      final Character? cachedCharacter = await localDataSource
          .getCachedCharacter(id: id);

      if (cachedCharacter != null) return Right(cachedCharacter);

      final Character remoteCharacters = await remoteDataSource.getCharacter(
        id: id,
      );

      return Right(remoteCharacters);
    } catch (e) {
      return Left(ServerFailure("Failed to fetch character"));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getList({int page = 1}) async {
    try {
      final List<Character>? cachedCharacters = await localDataSource
          .getCachedPage(page: page);

      if (cachedCharacters != null) return Right(cachedCharacters);

      final List<Character> remoteCharacters = await remoteDataSource.getList(
        page: page,
      );
      await localDataSource.cacheCharacterPage(
        page: page,
        characterPage: remoteCharacters,
      );

      return Right(remoteCharacters);
    } catch (e) {
      return Left(ServerFailure("Failed to fetch character"));
    }
  }
}
