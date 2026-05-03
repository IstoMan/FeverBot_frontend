import 'package:manifesto/features/dashboard/domain/entities/delete_member_entity.dart';

class DeleteMemberModel extends DeleteMemberEntity {
  DeleteMemberModel({
    required super.removedId,
    required super.groupId,
  });

  factory DeleteMemberModel.fromEntity(DeleteMemberEntity entity) {
    return DeleteMemberModel(
      removedId: entity.removedId,
      groupId: entity.groupId,
    );
  }

  factory DeleteMemberModel.fromJson(Map<String, dynamic> json) {
    return DeleteMemberModel(
      removedId: json['removed_uid'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'removed_id': removedId,
      'group_id': groupId,
    };
  }

  DeleteMemberEntity toEntity() {
    return DeleteMemberEntity(
      removedId: removedId,
      groupId: groupId,
    );
  }
}
