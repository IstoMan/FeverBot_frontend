import 'package:manifesto/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/onboarding/domain/entities/onboarding_request_entity.dart';

abstract class OnboardingRepository {
  ResultFuture<OnboardingEntity> getOnboardingData(
      {required OnboardingRequestEntity request});
}
