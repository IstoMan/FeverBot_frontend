import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/features/dashboard/domain/entities/dashboard_request_entity.dart';

abstract class DashboardRepository {
  ResultFuture<DashboardEntity> getDashboardData(
      {required DashboardRequestEntity request});
}
