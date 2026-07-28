import 'package:manifesto/features/dashboard/domain/entities/chat_stream_event.dart';
import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class StreamChatUseCase {
  final DashboardRepository repository;

  StreamChatUseCase({required this.repository});

  Stream<ChatStreamEvent> call(StreamChatUseCaseParams params) {
    return repository.streamChat(params.request);
  }
}

class StreamChatUseCaseParams {
  final SendChatRequestEntity request;

  StreamChatUseCaseParams({
    required this.request,
  });
}
