import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';

/// This is an example model class extending example model entity
class DashboardModel extends DashboardEntity {
  DashboardModel({
    required super.id,
    required super.name,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  DashboardEntity toEntity() {
    return DashboardEntity(
      id: id,
      name: name,
    );
  }

  factory DashboardModel.fromEntity(DashboardEntity entity) {
    return DashboardModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
