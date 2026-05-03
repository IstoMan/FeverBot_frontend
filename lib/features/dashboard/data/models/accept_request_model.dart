import 'package:manifesto/features/dashboard/domain/entities/accept_request_entity.dart';

class AcceptRequestModel extends AcceptRequestEntity {
  AcceptRequestModel({
    required super.token,
  });

  factory AcceptRequestModel.fromEntity(AcceptRequestEntity entity) {
    return AcceptRequestModel(
      token: entity.token,
    );
  }

  factory AcceptRequestModel.fromJson(Map<String, dynamic> json) {
    return AcceptRequestModel(
      token: json['token'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  AcceptRequestEntity toEntity() {
    return AcceptRequestEntity(
      token: token,
    );
  }
}
