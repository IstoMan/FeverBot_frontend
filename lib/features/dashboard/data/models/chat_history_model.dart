import 'package:manifesto/features/dashboard/domain/entities/chat_history_entity.dart';

class ChatHistoryModel extends ChatHistoryEntity {
  ChatHistoryModel({
    required super.id,
    required super.title,
    required super.createdAt,
    required super.lastUpdated,
  });

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: json['created_at'] as String,
      lastUpdated: json['last_updated'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt,
      'last_updated': lastUpdated,
    };
  }

  ChatHistoryEntity toEntity() {
    return ChatHistoryEntity(
      id: id,
      title: title,
      createdAt: createdAt,
      lastUpdated: lastUpdated,
    );
  }

  factory ChatHistoryModel.fromEntity(ChatHistoryEntity entity) {
    return ChatHistoryModel(
      id: entity.id,
      title: entity.title,
      createdAt: entity.createdAt,
      lastUpdated: entity.lastUpdated,
    );
  }
}
