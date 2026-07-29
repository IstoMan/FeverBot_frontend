class DocumentTypes {
  static const labReport = 'Lab Report';
  static const prescription = 'Prescription';
  static const insurance = 'Insurance';
  static const scanXRay = 'Scan / X-Ray';
  static const other = 'other';

  static const List<String> all = [
    labReport,
    prescription,
    insurance,
    scanXRay,
    other,
  ];
}

class DocumentEntity {
  final String id;
  final String filename;
  final String contentType;
  final int sizeBytes;
  final String storagePath;
  final String storageUri;
  final String? updatedAt;
  final String? type;
  final String? analysisModel;
  final String? recommendationsText;

  const DocumentEntity({
    required this.id,
    required this.filename,
    required this.contentType,
    required this.sizeBytes,
    required this.storagePath,
    required this.storageUri,
    this.updatedAt,
    this.type,
    this.analysisModel,
    this.recommendationsText,
  });

  DocumentEntity copyWith({
    String? id,
    String? filename,
    String? contentType,
    int? sizeBytes,
    String? storagePath,
    String? storageUri,
    String? updatedAt,
    String? type,
    String? analysisModel,
    String? recommendationsText,
  }) {
    return DocumentEntity(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      contentType: contentType ?? this.contentType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      storagePath: storagePath ?? this.storagePath,
      storageUri: storageUri ?? this.storageUri,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      analysisModel: analysisModel ?? this.analysisModel,
      recommendationsText: recommendationsText ?? this.recommendationsText,
    );
  }
}

class UploadDocumentRequestEntity {
  final String filePath;
  final String filename;
  final String? type;
  final bool analyze;

  const UploadDocumentRequestEntity({
    required this.filePath,
    required this.filename,
    this.type,
    this.analyze = false,
  });
}

class DocumentDownloadEntity {
  final String filename;
  final List<int> bytes;
  final String? contentType;

  const DocumentDownloadEntity({
    required this.filename,
    required this.bytes,
    this.contentType,
  });
}
