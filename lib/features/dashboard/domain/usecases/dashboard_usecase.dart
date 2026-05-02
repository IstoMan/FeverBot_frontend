import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardUseCase implements UseCaseWithoutParams<DashboardEntity> {
  final DashboardRepository repository;

  GetDashboardUseCase(this.repository);

  @override
  ResultFuture<DashboardEntity> call() async {
    return await repository.getDashboardData();
  }
}
