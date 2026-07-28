/// Events emitted while streaming a chat assistant reply over SSE.
sealed class ChatStreamEvent {
  const ChatStreamEvent();
}

class ChatStreamMessageStart extends ChatStreamEvent {
  final String? chatId;
  final String? turnId;

  const ChatStreamMessageStart({this.chatId, this.turnId});
}

class ChatStreamToken extends ChatStreamEvent {
  final String text;

  const ChatStreamToken(this.text);
}

class ChatStreamMessageEnd extends ChatStreamEvent {
  final String? chatId;
  final String? turnId;

  const ChatStreamMessageEnd({this.chatId, this.turnId});
}

class ChatStreamError extends ChatStreamEvent {
  final String message;

  const ChatStreamError(this.message);
}

/// tool_call / tool_result / citation — acknowledged but not rendered.
class ChatStreamIgnored extends ChatStreamEvent {
  final String type;

  const ChatStreamIgnored(this.type);
}
