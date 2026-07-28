class ChatMessage {
  static int _nextId = 0;

  String text;
  final bool isUser;
  final String id;
  bool animateEntrance;

  ChatMessage({
    required this.text,
    required this.isUser,
    String? id,
    this.animateEntrance = true,
  }) : id = id ?? 'msg_${++_nextId}';
}
