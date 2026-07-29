import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';

class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.id,
    required super.filename,
    required super.contentType,
    required super.sizeBytes,
    required super.storagePath,
    required super.storageUri,
    super.updatedAt,
    super.type,
    super.analysisModel,
    super.recommendationsText,
  });

  factory DocumentModel.fromEntity(DocumentEntity entity) {
    return DocumentModel(
      id: entity.id,
      filename: entity.filename,
      contentType: entity.contentType,
      sizeBytes: entity.sizeBytes,
      storagePath: entity.storagePath,
      storageUri: entity.storageUri,
      updatedAt: entity.updatedAt,
      type: entity.type,
      analysisModel: entity.analysisModel,
      recommendationsText: entity.recommendationsText,
    );
  }

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id']?.toString() ?? json['filename']?.toString() ?? '',
      filename: json['filename']?.toString() ?? '',
      contentType: json['content_type']?.toString() ?? '',
      sizeBytes: _asInt(json['size_bytes']),
      storagePath: json['storage_path']?.toString() ?? '',
      storageUri: json['storage_uri']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString(),
      type: json['type']?.toString(),
      analysisModel: json['analysis_model']?.toString(),
      recommendationsText: json['recommendations_text']?.toString(),
    );
  }

  /// Maps `POST /documents/{id}/analyze` response onto an existing document.
  factory DocumentModel.fromAnalyzeJson(
    Map<String, dynamic> json, {
    required DocumentEntity existing,
  }) {
    return DocumentModel(
      id: json['doc_id']?.toString() ?? existing.id,
      filename: existing.filename,
      contentType: existing.contentType,
      sizeBytes: existing.sizeBytes,
      storagePath: existing.storagePath,
      storageUri: existing.storageUri,
      updatedAt: existing.updatedAt,
      type: existing.type,
      analysisModel:
          json['analysis_model']?.toString() ?? existing.analysisModel,
      recommendationsText: json['recommendations_text']?.toString() ??
          existing.recommendationsText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filename': filename,
      'content_type': contentType,
      'size_bytes': sizeBytes,
      'storage_path': storagePath,
      'storage_uri': storageUri,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (type != null) 'type': type,
      if (analysisModel != null) 'analysis_model': analysisModel,
      if (recommendationsText != null)
        'recommendations_text': recommendationsText,
    };
  }

  DocumentEntity toEntity() {
    return DocumentEntity(
      id: id,
      filename: filename,
      contentType: contentType,
      sizeBytes: sizeBytes,
      storagePath: storagePath,
      storageUri: storageUri,
      updatedAt: updatedAt,
      type: type,
      analysisModel: analysisModel,
      recommendationsText: recommendationsText,
    );
  }

  static int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
