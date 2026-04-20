import 'package:manifesto/features/dashboard/domain/entities/dashboard_request_entity.dart';

class DashboardRequestModel extends DashboardRequestEntity {
  DashboardRequestModel({
    required super.id,
  });

  factory DashboardRequestModel.fromEntity(DashboardRequestEntity entity) {
    return DashboardRequestModel(
      id: entity.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  DashboardRequestEntity toEntity() {
    return DashboardRequestEntity(
      id: id,
    );
  }
}
