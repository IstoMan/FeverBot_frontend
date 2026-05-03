import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/chat_history_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetChatsUseCase extends UseCaseWithoutParams<List<ChatHistoryEntity>> {
  final DashboardRepository repository;

  GetChatsUseCase({required this.repository});

  @override
  ResultFuture<List<ChatHistoryEntity>> call() async {
    return await repository.getChats();
  }
}
