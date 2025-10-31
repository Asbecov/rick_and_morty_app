import 'package:dartz/dartz.dart';

import 'package:rick_and_morty_app/common/domain/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
