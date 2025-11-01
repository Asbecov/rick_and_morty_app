import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/common/domain/errors/failures.dart';
import 'package:rick_and_morty_app/common/domain/use_cases/use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/repositories/favourites.dart';

class AddFavouriteUseCase implements UseCase<void, AddFavouriteParams> {
  final FavouritesRepository favouritesRepository;

  const AddFavouriteUseCase({required this.favouritesRepository});

  @override
  Future<Either<Failure, void>> call(AddFavouriteParams params) =>
      favouritesRepository.addFavourite(character: params.character);
}

class AddFavouriteParams {
  final Character character;

  const AddFavouriteParams(this.character);
}
