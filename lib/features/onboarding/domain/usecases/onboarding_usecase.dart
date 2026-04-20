import 'package:manifesto/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_request_entity.dart';

///NOTE: class can be implemented with UseCaseWithoutParams as well if no parameters needs to be pass
///NOTE: If more use-cases needs to be added then make separate usecase file
class GetOnboardingUseCase
    implements
        UseCaseWithParams<OnboardingEntity, GetOnboardingDataUseCaseParams> {
  final OnboardingRepository repository;
  GetOnboardingUseCase(this.repository);
  @override
  ResultFuture<OnboardingEntity> call(
      GetOnboardingDataUseCaseParams params) async {
    return await repository.getOnboardingData(request: params.request);
  }
}

class GetOnboardingDataUseCaseParams {
  final OnboardingRequestEntity request;
  GetOnboardingDataUseCaseParams({required this.request});
}
