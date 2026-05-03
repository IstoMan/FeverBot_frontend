import 'package:manifesto/features/dashboard/domain/entities/invite_entity.dart';

class InviteModel extends InviteEntity {
  InviteModel({
    required super.token,
    required super.inviteUrl,
    required super.expiresAt,
    required super.QRBase64,
    required super.QRMediaType,
    required super.targetRole,
  });

  factory InviteModel.fromEntity(InviteEntity entity) {
    return InviteModel(
      token: entity.token,
      inviteUrl: entity.inviteUrl,
      expiresAt: entity.expiresAt,
      QRBase64: entity.QRBase64,
      QRMediaType: entity.QRMediaType,
      targetRole: entity.targetRole,
    );
  }

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      token: json['token'] as String? ?? '',
      inviteUrl: json['invite_url'] as String? ?? '',
      expiresAt: json['expires_at'] as String? ?? '',
      QRBase64: json['qr_png_base64'] as String? ?? '',
      QRMediaType: json['qr_media_type'] as String? ?? '',
      targetRole: json['target_role'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'invite_url': inviteUrl,
      'expires_at': expiresAt,
      'qr_base64': QRBase64,
      'qr_media_type': QRMediaType,
      'target_role': targetRole,
    };
  }

  InviteEntity toEntity() {
    return InviteEntity(
      token: token,
      inviteUrl: inviteUrl,
      expiresAt: expiresAt,
      QRBase64: QRBase64,
      QRMediaType: QRMediaType,
      targetRole: targetRole,
    );
  }
}
