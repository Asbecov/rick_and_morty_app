import 'package:dartz/dartz.dart';

import 'package:rick_and_morty_app/common/domain/errors/failures.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/favourites_local_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/remote/remote_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/repositories/favourites.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  final FavouritesLocalDataSource favouritesLocalDataSource;
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  const FavouritesRepositoryImpl({
    required this.favouritesLocalDataSource,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> addFavourite({
    required Character character,
  }) async {
    try {
      await favouritesLocalDataSource.addFavourite(id: character.id);

      return Right(null);
    } catch (e) {
      return Left(CacheFailure("Couldn't save the favourite"));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getFavourites() async {
    try {
      final List<int> favouriteIds = await favouritesLocalDataSource
          .getFavourites();

      final List<Character> characters = [];

      for (final int id in favouriteIds) {
        try {
          final Character? cachedCharacter = await localDataSource
              .getCachedCharacter(id: id);

          if (cachedCharacter != null) {
            characters.add(cachedCharacter);
          } else {
            final Character remoteCharacter = await remoteDataSource
                .getCharacter(id: id);
            characters.add(remoteCharacter);
          }
        } catch (e) {
          continue;
        }
      }

      return Right(characters);
    } catch (e) {
      return Left(CacheFailure("Couldn't load favourites"));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavourite({
    required Character character,
  }) async {
    try {
      await favouritesLocalDataSource.removeFavourite(id: character.id);

      return Right(null);
    } catch (e) {
      return Left(CacheFailure("Couldn't remove the favourite"));
    }
  }
}
