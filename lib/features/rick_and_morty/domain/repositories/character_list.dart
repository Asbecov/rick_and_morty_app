import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/common/domain/errors/failures.dart';
import 'package:rick_and_morty_app/features/rick_and_morty/domain/models/character.dart';

abstract interface class CharacterListRepository {
  Future<Either<Failure, List<Character>>> getList({int page = 1});

  Future<Either<Failure, Character>> getCharacter({required int id});
}
