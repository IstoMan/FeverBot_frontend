import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class DownloadDocumentUseCase extends UseCaseWithParams<DocumentDownloadEntity,
    DownloadDocumentUseCaseParams> {
  final DashboardRepository repository;

  DownloadDocumentUseCase({required this.repository});

  @override
  ResultFuture<DocumentDownloadEntity> call(
      DownloadDocumentUseCaseParams params) async {
    return await repository.downloadDocument(params.document);
  }
}

class DownloadDocumentUseCaseParams {
  final DocumentEntity document;

  DownloadDocumentUseCaseParams({required this.document});
}
