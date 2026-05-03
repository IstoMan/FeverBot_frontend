import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/family_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetFamilyUseCase extends UseCaseWithoutParams<FamilyEntity> {
  final DashboardRepository repository;

  GetFamilyUseCase({required this.repository});

  @override
  ResultFuture<FamilyEntity> call() async {
    return await repository.getFamily();
  }
}
