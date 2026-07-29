import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class UploadDocumentUseCase
    extends UseCaseWithParams<DocumentEntity, UploadDocumentUseCaseParams> {
  final DashboardRepository repository;

  UploadDocumentUseCase({required this.repository});

  @override
  ResultFuture<DocumentEntity> call(UploadDocumentUseCaseParams params) async {
    return await repository.uploadDocument(params.request);
  }
}

class UploadDocumentUseCaseParams {
  final UploadDocumentRequestEntity request;

  UploadDocumentUseCaseParams({required this.request});
}
