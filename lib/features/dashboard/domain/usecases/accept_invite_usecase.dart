import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/accept_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/family_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class AcceptInviteUseCase
    extends UseCaseWithParams<FamilyEntity, AcceptInviteUseCaseParams> {
  final DashboardRepository repository;

  AcceptInviteUseCase({required this.repository});

  @override
  ResultFuture<FamilyEntity> call(AcceptInviteUseCaseParams params) async {
    return await repository.acceptInvite(params.request);
  }
}

class AcceptInviteUseCaseParams {
  final AcceptRequestEntity request;

  AcceptInviteUseCaseParams({required this.request});
}
