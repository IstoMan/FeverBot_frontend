import 'package:manifesto/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    required super.riskClass,
    required super.riskScore,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      riskScore: (json['risk_score'] as num?)?.toDouble() ?? 0.0,
      riskClass: json['risk_class'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'risk_score': riskScore,
      'risk_class': riskClass,
    };
  }

  DashboardEntity toEntity() {
    return DashboardEntity(riskClass: riskClass, riskScore: riskScore);
  }

  factory DashboardModel.fromEntity(DashboardEntity entity) {
    return DashboardModel(
      riskScore: entity.riskScore,
      riskClass: entity.riskClass,
    );
  }
}
