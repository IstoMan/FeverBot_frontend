import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_request_entity.dart';

///NOTE: class can be implemented with UseCaseWithoutParams as well if no parameters needs to be pass
///NOTE: If more use-cases needs to be added then make separate usecase file
class GetDashboardUseCase
    implements
        UseCaseWithParams<DashboardEntity, GetDashboardDataUseCaseParams> {
  final DashboardRepository repository;
  GetDashboardUseCase(this.repository);
  @override
  ResultFuture<DashboardEntity> call(
      GetDashboardDataUseCaseParams params) async {
    return await repository.getDashboardData(request: params.request);
  }
}

class GetDashboardDataUseCaseParams {
  final DashboardRequestEntity request;
  GetDashboardDataUseCaseParams({required this.request});
}
