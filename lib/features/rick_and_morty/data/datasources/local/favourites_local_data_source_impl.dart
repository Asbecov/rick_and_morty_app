import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/favourites_local_data_source.dart';

class FavouritesLocalDataSourceImpl implements FavouritesLocalDataSource {
  static String favoruitesBoxName = "favourites";

  @override
  Future<List<int>> getFavourites() async {
    final Box<int> box = await Hive.openBox<int>(favoruitesBoxName);

    return box.values.toList();
  }

  @override
  Future addFavourite({required int id}) async {
    final Box<int> box = await Hive.openBox<int>(favoruitesBoxName);

    await box.put(id, id);
  }

  @override
  Future removeFavourite({required int id}) async {
    final Box<int> box = await Hive.openBox<int>(favoruitesBoxName);

    await box.delete(id);
  }

  @override
  Future clearCache() => Hive.deleteBoxFromDisk(favoruitesBoxName);
}
