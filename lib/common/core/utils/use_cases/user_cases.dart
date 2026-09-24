import 'package:manifesto/common/core/utils/type_def/type_def.dart';

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class UseCaseWithParamsResultVoid<Params> {
  const UseCaseWithParamsResultVoid();

  ResultVoid call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  ResultFuture<T> call();
}
