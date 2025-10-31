import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract interface class FavouritesRepository {
  Future<List<Character>> getFavourites();

  Future addFavourite({required Character character});

  Future removeFavourite({required Character character});
}
