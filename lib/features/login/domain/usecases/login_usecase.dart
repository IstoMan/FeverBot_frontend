import 'package:manifesto/features/login/domain/repositories/login_repository.dart';
import 'package:manifesto/features/login/domain/entities/login_entity.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';

///NOTE: class can be implemented with UseCaseWithoutParams as well if no parameters needs to be pass
///NOTE: If more use-cases needs to be added then make separate usecase file
class GetLoginUseCase
    implements UseCaseWithParams<LoginEntity, GetLoginDataUseCaseParams> {
  final LoginRepository repository;
  GetLoginUseCase(this.repository);
  @override
  ResultFuture<LoginEntity> call(GetLoginDataUseCaseParams params) async {
    return await repository.getLoginData(request: params.request);
  }
}

class GetLoginDataUseCaseParams {
  final LoginRequestEntity request;
  GetLoginDataUseCaseParams({required this.request});
}
