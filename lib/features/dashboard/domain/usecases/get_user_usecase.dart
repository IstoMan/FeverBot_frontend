import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/user_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetUserUseCase implements UseCaseWithoutParams<UserEntity> {
  final DashboardRepository repository;

  GetUserUseCase({required this.repository});

  @override
  ResultFuture<UserEntity> call() async {
    return await repository.getUser();
  }
}
