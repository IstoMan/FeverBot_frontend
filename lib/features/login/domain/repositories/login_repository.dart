import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/login/domain/entities/login_entity.dart';
import 'package:manifesto/features/login/domain/entities/login_request_entity.dart';

abstract class LoginRepository {
  ResultFuture<LoginEntity> login({
    required LoginRequestEntity request,
  });
}
