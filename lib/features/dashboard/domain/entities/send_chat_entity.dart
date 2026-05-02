class SendChatEntity {
  final String chatId;
  final String turnId;
  final String role;
  final String content;
  final String newTitle;
  final String state;

  SendChatEntity({
    required this.chatId,
    required this.turnId,
    required this.role,
    required this.content,
    required this.newTitle,
    required this.state,
  });
}
