class FamilyMemberEntity {
  final String uuid;
  final String name;
  final String role;

  FamilyMemberEntity({
    required this.uuid,
    required this.name,
    required this.role,
  });
}

class FamilyEntity {
  final String groupId;
  final String ownerId;
  final List<FamilyMemberEntity> members;

  FamilyEntity({
    required this.groupId,
    required this.ownerId,
    required this.members,
  });
}
