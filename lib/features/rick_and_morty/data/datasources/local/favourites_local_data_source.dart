import 'dart:async';

abstract interface class FavouritesLocalDataSource {
  FutureOr<List<int>> getFavourites();

  FutureOr addFavourite({required int id});

  FutureOr removeFavourite({required int id});

  FutureOr clearCache();
}
