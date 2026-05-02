import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

import '../entities/send_chat_request_entity.dart';

class SendChatUseCase
    extends UseCaseWithParams<SendChatEntity, SendChatUseCaseParams> {
  final DashboardRepository repository;

  SendChatUseCase({required this.repository});

  @override
  ResultFuture<SendChatEntity> call(SendChatUseCaseParams params) async {
    return await repository.sendChat(params.request);
  }
}

class SendChatUseCaseParams {
  final SendChatRequestEntity request;

  SendChatUseCaseParams({
    required this.request,
  });
}
