import 'package:manifesto/features/dashboard/domain/entities/send_chat_request_entity.dart';

class SendChatRequestModel extends SendChatRequestEntity {
  SendChatRequestModel({
    required super.chatId,
    required super.message,
  });

  factory SendChatRequestModel.fromEntity(SendChatRequestEntity entity) {
    return SendChatRequestModel(
      chatId: entity.chatId,
      message: entity.message,
    );
  }

  factory SendChatRequestModel.fromJson(Map<String, dynamic> json) {
    return SendChatRequestModel(
      chatId: json['chat_id'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

  SendChatRequestEntity toEntity() {
    return SendChatRequestEntity(
      chatId: chatId,
      message: message,
    );
  }
}
