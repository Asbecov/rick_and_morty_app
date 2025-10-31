import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/common/domain/errors/failures.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract interface class FavouritesRepository {
  Future<Either<Failure, List<Character>>> getFavourites();

  Future<Either<Failure, void>> addFavourite({required Character character});

  Future<Either<Failure, void>> removeFavourite({required Character character});
}
