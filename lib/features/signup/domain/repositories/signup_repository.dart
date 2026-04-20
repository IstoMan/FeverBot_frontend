import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/signup/domain/entities/signup_request_entity.dart';

abstract class SignupRepository {
  ResultVoid getSignupData({
    required SignupRequestEntity request,
  });
}
