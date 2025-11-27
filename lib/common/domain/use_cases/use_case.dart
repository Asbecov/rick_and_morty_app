import 'package:dartz/dartz.dart';

import 'package:rick_and_morty_app/common/domain/errors/failures.dart';

abstract class UseCase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}
