import 'package:manifesto/features/dashboard/domain/entities/delete_member_request_entity.dart';

class DeleteMemberRequestModel extends DeleteMemberRequestEntity {
  DeleteMemberRequestModel({
    required super.memberId,
  });

  factory DeleteMemberRequestModel.fromEntity(DeleteMemberRequestEntity entity) {
    return DeleteMemberRequestModel(
      memberId: entity.memberId,
    );
  }

  factory DeleteMemberRequestModel.fromJson(Map<String, dynamic> json) {
    return DeleteMemberRequestModel(
      memberId: json['member_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
    };
  }

  DeleteMemberRequestEntity toEntity() {
    return DeleteMemberRequestEntity(
      memberId: memberId,
    );
  }
}
