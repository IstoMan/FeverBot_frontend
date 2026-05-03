import 'package:manifesto/features/dashboard/domain/entities/family_entity.dart';

class FamilyMemberModel extends FamilyMemberEntity {
  FamilyMemberModel({
    required super.uuid,
    required super.name,
    required super.role,
  });

  factory FamilyMemberModel.fromEntity(FamilyMemberEntity entity) {
    return FamilyMemberModel(
      uuid: entity.uuid,
      name: entity.name,
      role: entity.role,
    );
  }

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      uuid: json['uid'] as String? ?? '',
      name: json['display_name'] as String? ?? '',
      role: json['role_relative_to_me'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uuid,
      'display_name': name,
      'role_relative_to_me': role,
    };
  }

  FamilyMemberEntity toEntity() {
    return FamilyMemberEntity(
      uuid: uuid,
      name: name,
      role: role,
    );
  }
}

class FamilyModel extends FamilyEntity {
  FamilyModel({
    required super.groupId,
    required super.ownerId,
    required super.members,
  });

  factory FamilyModel.fromEntity(FamilyEntity entity) {
    return FamilyModel(
      groupId: entity.groupId,
      ownerId: entity.ownerId,
      members:
          entity.members.map((m) => FamilyMemberModel.fromEntity(m)).toList(),
    );
  }

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    return FamilyModel(
      groupId: json['group_id'] as String? ?? '',
      ownerId: json['owner_uid'] as String? ?? '',
      members: (json['members'] as List<dynamic>? ?? [])
          .map((m) => FamilyMemberModel.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'owner_uid': ownerId,
      'members':
          members.map((m) => FamilyMemberModel.fromEntity(m).toJson()).toList(),
    };
  }

  FamilyEntity toEntity() {
    return FamilyEntity(
      groupId: groupId,
      ownerId: ownerId,
      members: members
          .map((m) => FamilyMemberModel.fromEntity(m).toEntity())
          .toList(),
    );
  }
}
