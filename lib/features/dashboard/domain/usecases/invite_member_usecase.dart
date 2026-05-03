import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/invite_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class InviteMemberUseCase
    extends UseCaseWithParams<InviteEntity, InviteMemberUseCaseParams> {
  final DashboardRepository repository;

  InviteMemberUseCase({required this.repository});

  @override
  ResultFuture<InviteEntity> call(InviteMemberUseCaseParams params) async {
    return await repository.inviteMember(params.request);
  }
}

class InviteMemberUseCaseParams {
  final InviteRequestEntity request;

  InviteMemberUseCaseParams({required this.request});
}
