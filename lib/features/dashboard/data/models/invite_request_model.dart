import 'package:manifesto/features/dashboard/domain/entities/invite_request_entity.dart';

class InviteRequestModel extends InviteRequestEntity {
  InviteRequestModel({
    required super.targetRole,
  });

  factory InviteRequestModel.fromEntity(InviteRequestEntity entity) {
    return InviteRequestModel(
      targetRole: entity.targetRole,
    );
  }

  factory InviteRequestModel.fromJson(Map<String, dynamic> json) {
    return InviteRequestModel(
      targetRole: json['target_role'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target_role': targetRole,
    };
  }

  InviteRequestEntity toEntity() {
    return InviteRequestEntity(
      targetRole: targetRole,
    );
  }
}
