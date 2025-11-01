import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/favourites_local_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/favourites_local_data_source_impl.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/local_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/local_data_source_impl.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/remote/remote_data_source.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/remote/remote_data_source_impl.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/remote/rick_and_morty_api.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/repositories/character_list_impl.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/repositories/favourites_impl.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/repositories/character_list.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/repositories/favourites.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/usecases/add_favourite_use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/usecases/load_characters_use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/usecases/load_favourites_use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/usecases/remove_favourite_use_case.dart';

final Dio dio = Dio();
final RickAndMortyApi api = RickAndMortyApi(dio);

final RemoteDataSource remoteDataSource = RemoteDataSourceImpl(api: api);
final LocalDataSource localDataSource = LocalDataSourceImpl();
final FavouritesLocalDataSource favouritesLocalDataSource =
    FavouritesLocalDataSourceImpl();

final CharacterListRepository characterListRepository =
    CharacterListRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );

final FavouritesRepository favouritesRepository = FavouritesRepositoryImpl(
  favouritesLocalDataSource: favouritesLocalDataSource,
  localDataSource: localDataSource,
  remoteDataSource: remoteDataSource,
);

final LoadCharactersUseCase loadCharactersUseCase = LoadCharactersUseCase(
  characterListRepository: characterListRepository,
);

final LoadFavouritesUseCase loadFavouritesUseCase = LoadFavouritesUseCase(
  favouritesRepository: favouritesRepository,
);

final AddFavouriteUseCase addFavouriteUseCase = AddFavouriteUseCase(
  favouritesRepository: favouritesRepository,
);

final RemoveFavouriteUseCase removeFavouriteUseCase = RemoveFavouriteUseCase(
  favouritesRepository: favouritesRepository,
);
