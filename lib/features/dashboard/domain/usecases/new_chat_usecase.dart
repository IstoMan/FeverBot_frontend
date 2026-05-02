import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/new_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class NewChatUseCase extends UseCaseWithoutParams<NewChatEntity> {
  final DashboardRepository repository;

  NewChatUseCase({required this.repository});

  @override
  ResultFuture<NewChatEntity> call() async {
    return await repository.startChat();
  }
}
