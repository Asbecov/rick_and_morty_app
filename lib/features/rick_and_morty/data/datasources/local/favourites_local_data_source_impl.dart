import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/data/datasources/local/favourites_local_data_source.dart';

class FavouritesLocalDataSourceImpl implements FavouritesLocalDataSource {
  final Box<int> hiveBox;

  const FavouritesLocalDataSourceImpl(this.hiveBox);

  static String favoruitesBoxName = "favourites";

  @override
  List<int> getFavourites() => hiveBox.values.toList();

  @override
  Future addFavourite({required int id}) => hiveBox.put(id, id);

  @override
  Future removeFavourite({required int id}) => hiveBox.delete(id);

  @override
  Future clearCache() => Hive.deleteBoxFromDisk(favoruitesBoxName);
}
