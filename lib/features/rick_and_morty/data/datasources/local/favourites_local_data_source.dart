abstract interface class FavouritesLocalDataSource {
  Future<List<int>> getFavourites();

  Future addFavourite({required int id});

  Future removeFavourite({required int id});

  Future clearCache();
}
