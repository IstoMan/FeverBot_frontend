import 'package:manifesto/features/dashboard/domain/entities/new_chat_entity.dart';

class NewChatModel extends NewChatEntity {
  NewChatModel({
    required super.id,
    required super.title,
    required super.createdAt,
    required super.lastUpdated,
  });

  factory NewChatModel.fromEntity(NewChatEntity entity) {
    return NewChatModel(
      id: entity.id,
      title: entity.title,
      createdAt: entity.createdAt,
      lastUpdated: entity.lastUpdated,
    );
  }

  factory NewChatModel.fromJson(Map<String, dynamic> json) {
    return NewChatModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      lastUpdated: json['last_updated'] as String? ?? '',
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

  NewChatEntity toEntity() {
    return NewChatEntity(
      id: id,
      title: title,
      createdAt: createdAt,
      lastUpdated: lastUpdated,
    );
  }
}
