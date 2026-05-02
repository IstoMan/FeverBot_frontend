import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/login/domain/entities/login_entity.dart';
import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';
import 'package:manifesto/features/login/domain/repositories/login_repository.dart';

class GetLoginUseCase
    implements UseCaseWithParams<LoginEntity, GetLoginDataUseCaseParams> {
  final LoginRepository repository;

  GetLoginUseCase(this.repository);

  @override
  ResultFuture<LoginEntity> call(GetLoginDataUseCaseParams params) async {
    return await repository.login(request: params.request);
  }
}

class GetLoginDataUseCaseParams {
  final LoginRequestEntity request;

  GetLoginDataUseCaseParams({required this.request});
}
