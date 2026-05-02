import 'package:manifesto/features/dashboard/domain/entities/send_chat_entity.dart';

class SendChatModel extends SendChatEntity {
  SendChatModel({
    required super.chatId,
    required super.turnId,
    required super.role,
    required super.content,
    required super.newTitle,
    required super.state,
  });

  factory SendChatModel.fromEntity(SendChatEntity entity) {
    return SendChatModel(
      chatId: entity.chatId,
      turnId: entity.turnId,
      role: entity.role,
      content: entity.content,
      newTitle: entity.newTitle,
      state: entity.state,
    );
  }

  factory SendChatModel.fromJson(Map<String, dynamic> json) {
    return SendChatModel(
      chatId: json['chat_id'] as String? ?? '',
      turnId: json['turn_id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      content: json['content'] as String? ?? '',
      newTitle: json['new_title'] as String? ?? '',
      state: json['state'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
      'turn_id': turnId,
      'role': role,
      'content': content,
      'new_title': newTitle,
      'state': state,
    };
  }

  SendChatEntity toEntity() {
    return SendChatEntity(
      chatId: chatId,
      turnId: turnId,
      role: role,
      content: content,
      newTitle: newTitle,
      state: state,
    );
  }
}
