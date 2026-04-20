import 'package:manifesto/common/core/utils/type_def/type_def.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithParamsResultVoid<Params> {
  const UseCaseWithParamsResultVoid();

  ResultVoid call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();

  ResultFuture<Type> call();
}
