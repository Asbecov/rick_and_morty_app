import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/common/domain/errors/failures.dart';
import 'package:rick_and_morty_app/common/domain/use_cases/use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/repositories/favourites.dart';

class RemoveFavouriteUseCase implements UseCase<void, RemoveFavouriteParams> {
  final FavouritesRepository favouritesRepository;

  const RemoveFavouriteUseCase({required this.favouritesRepository});

  @override
  Future<Either<Failure, void>> call(RemoveFavouriteParams params) =>
      favouritesRepository.removeFavourite(character: params.character);
}

class RemoveFavouriteParams {
  final Character character;

  const RemoveFavouriteParams(this.character);
}
