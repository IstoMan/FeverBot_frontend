class InviteEntity {
  final String token;
  final String inviteUrl;
  final String expiresAt;
  final String qrBase64;
  final String qrMediaType;
  final String targetRole;

  InviteEntity({
    required this.token,
    required this.inviteUrl,
    required this.expiresAt,
    required this.qrBase64,
    required this.qrMediaType,
    required this.targetRole,
  });
}
