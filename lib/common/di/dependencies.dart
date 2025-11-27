import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

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

final sl = GetIt.instance;

class AppDi {
  static Future<void> initDi() async {
    final Box<int> favouritesBox = await Hive.openBox(
      FavouritesLocalDataSourceImpl.favoruitesBoxName,
    );
    final Box<List<dynamic>> hiveBox = await Hive.openBox(
      LocalDataSourceImpl.characterBoxName,
    );

    sl.registerLazySingleton<Dio>(() => Dio());
    sl.registerSingleton<Box<int>>(favouritesBox);
    sl.registerSingleton<Box<List<dynamic>>>(hiveBox);

    sl.registerLazySingleton<RickAndMortyApi>(() => RickAndMortyApi(sl()));

    sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(api: sl()),
    );

    sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(sl()));

    sl.registerLazySingleton<FavouritesLocalDataSource>(
      () => FavouritesLocalDataSourceImpl(sl()),
    );

    sl.registerLazySingleton<CharacterListRepository>(
      () => CharacterListRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
      ),
    );

    sl.registerLazySingleton<FavouritesRepository>(
      () => FavouritesRepositoryImpl(
        favouritesLocalDataSource: sl(),
        localDataSource: sl(),
        remoteDataSource: sl(),
      ),
    );

    // ===== USE CASES =====
    sl.registerFactory(
      () => LoadCharactersUseCase(characterListRepository: sl()),
    );

    sl.registerFactory(() => LoadFavouritesUseCase(favouritesRepository: sl()));

    sl.registerFactory(() => AddFavouriteUseCase(favouritesRepository: sl()));

    sl.registerFactory(
      () => RemoveFavouriteUseCase(favouritesRepository: sl()),
    );
  }
}
