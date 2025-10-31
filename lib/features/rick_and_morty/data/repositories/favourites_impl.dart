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
  Future addFavourite({required Character character}) {
    // TODO: implement addFavourite
    throw UnimplementedError();
  }

  @override
  Future<List<Character>> getFavourites() {
    // TODO: implement getFavourites
    throw UnimplementedError();
  }

  @override
  Future removeFavourite({required Character character}) {
    // TODO: implement removeFavourite
    throw UnimplementedError();
  }
}
