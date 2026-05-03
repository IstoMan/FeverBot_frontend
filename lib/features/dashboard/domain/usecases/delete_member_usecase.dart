import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_entity.dart';
import 'package:manifesto/features/dashboard/domain/entities/delete_member_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class DeleteMemberUseCase
    extends UseCaseWithParams<DeleteMemberEntity, DeleteMemberUseCaseParams> {
  final DashboardRepository repository;

  DeleteMemberUseCase({required this.repository});

  @override
  ResultFuture<DeleteMemberEntity> call(
      DeleteMemberUseCaseParams params) async {
    return await repository.removeMember(params.request);
  }
}

class DeleteMemberUseCaseParams {
  final DeleteMemberRequestEntity request;

  DeleteMemberUseCaseParams({required this.request});
}
