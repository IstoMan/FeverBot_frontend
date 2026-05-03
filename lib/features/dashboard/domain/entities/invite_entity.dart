class InviteEntity {
  final String token;
  final String inviteUrl;
  final String expiresAt;
  final String QRBase64;
  final String QRMediaType;
  final String targetRole;

  InviteEntity({
    required this.token,
    required this.inviteUrl,
    required this.expiresAt,
    required this.QRBase64,
    required this.QRMediaType,
    required this.targetRole,
  });
}
