import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/common/domain/errors/failures.dart';
import 'package:rick_and_morty_app/common/domain/use_cases/use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/repositories/favourites.dart';

class LoadFavouritesUseCase
    implements UseCase<List<Character>, LoadFavouritesParams> {
  final FavouritesRepository favouritesRepository;

  const LoadFavouritesUseCase({required this.favouritesRepository});

  @override
  Future<Either<Failure, List<Character>>> call(LoadFavouritesParams params) =>
      favouritesRepository.getFavourites();
}

class LoadFavouritesParams {
  const LoadFavouritesParams();
}
