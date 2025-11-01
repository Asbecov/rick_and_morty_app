import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/common/domain/errors/failures.dart';
import 'package:rick_and_morty_app/common/domain/use_cases/use_case.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/repositories/character_list.dart';

class LoadCharactersUseCase
    implements UseCase<List<Character>, LoadCharactersParams> {
  final CharacterListRepository characterListRepository;

  const LoadCharactersUseCase({required this.characterListRepository});

  @override
  Future<Either<Failure, List<Character>>> call(LoadCharactersParams params) =>
      characterListRepository.getList(page: params.page);
}

class LoadCharactersParams {
  const LoadCharactersParams(this.page);

  final int page;
}
