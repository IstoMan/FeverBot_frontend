import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/signup/domain/entities/signup_entity.dart';
import 'package:manifesto/features/signup/domain/entities/signup_request_entity.dart';
import 'package:manifesto/features/signup/domain/repositories/signup_repository.dart';

class GetSignupUseCase
    implements UseCaseWithParams<SignupEntity, GetSignupDataUseCaseParams> {
  final SignupRepository repository;

  GetSignupUseCase(this.repository);

  @override
  ResultFuture<SignupEntity> call(GetSignupDataUseCaseParams params) async {
    return await repository.getSignupData(request: params.request);
  }
}

class GetSignupDataUseCaseParams {
  final SignupRequestEntity request;

  GetSignupDataUseCaseParams({required this.request});
}
